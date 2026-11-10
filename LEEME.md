# Index IT · Service Desk

Sistema de tickets de soporte IT para Index, S.A. (reemplaza Google Forms + Dashboard de Sheets).

## Cómo arrancar (3 pasos)

**Requisitos:** Node.js 20+ y Docker Desktop **abierto**.

1. Descomprime este ZIP.
2. Ejecuta el arranque:
   - **Windows:** doble clic en `iniciar.bat`
   - **Mac / Linux / Git Bash:** `bash iniciar.sh`
3. Abre **http://localhost:3000**

La primera vez instala dependencias solo (1–3 minutos). Levanta PostgreSQL + Redis (Docker),
el backend (puerto 4000) y el frontend (puerto 3000).

## Cuentas de demostración (dominio `index.com.gt`)

| Correo | Rol |
|---|---|
| alex.menchu@index.com.gt | Agente N3 · Jefe de IT (CRUD completo) |
| auxiliar.it@index.com.gt | Agente N3 · Auxiliar de IT (CRUD completo) |
| jose.cuevas@index.com.gt | Gerencia · solo lectura + Dashboard |
| empleado@index.com.gt | Usuario final (Portal) |

En la pantalla de login hay botones para entrar con un clic.

## Probar la detección de colisión
Entra como Alex en una ventana normal y como Auxiliar en una de incógnito. Abre el mismo ticket en ambas:
verás la alerta, y si uno escribe, el otro lo ve en tiempo real.

## Manual (si prefieres paso a paso)
```bash
docker compose up -d --wait
cd backend  && npm install && npm run dev      # terminal 1
cd frontend && npm install && npm run dev      # terminal 2
```

## Cosas a ajustar antes de producción
- **Correos reales:** edita `db/02_seed.sql` (los del seed son ejemplos).
- **Datos demo:** borra `db/03_demo_data.sql` antes del primer arranque en producción.
- **SSO:** el login actual es simulado (`/api/auth/sso/dev`). Sustitúyelo por OIDC de Google Workspace / Microsoft Entra.
- **Seguridad:** cambia `JWT_SECRET` y las credenciales de la BD (`backend/.env`, `docker-compose.yml`) y usa HTTPS.
- **IA de deflexión (opcional):** pon tu `ANTHROPIC_API_KEY` en `backend/.env`. Sin clave, solo usa la base de conocimiento.
- **SLA:** corre 24x7 (no considera horario laboral). Editable en la tabla `sla_policies`.
- **Notificaciones por correo:** los watchers se guardan, pero aún no se envían correos.

## Reiniciar la base de datos desde cero
```bash
docker compose down -v && docker compose up -d --wait
```

## Estructura
```
db/        esquema, seed y datos demo (se ejecutan solos al crear el contenedor)
backend/   Express 5 · PostgreSQL · Redis · Socket.io · node-cron (SLA + auto-cierre)
frontend/  Next.js 14 · Tailwind · Tremor · lucide-react
```
