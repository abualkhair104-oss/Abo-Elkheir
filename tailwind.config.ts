import type { Config } from 'tailwindcss';
const config: Config = { content: ['./src/**/*.{ts,tsx}'], theme: { extend: { colors: { ink:'#101010', ivory:'#F5F1E8', gold:'#B7A27A', charcoal:'#292929' }, fontFamily: { sans:['var(--font-cairo)','sans-serif'] } } }, plugins: [] };
export default config;
