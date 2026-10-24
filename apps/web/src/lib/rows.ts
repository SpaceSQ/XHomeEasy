export function asRows<T>(data: unknown): T[] {
  return Array.isArray(data) ? (data as T[]) : [];
}

export function asOne<T>(data: unknown): T | null {
  if (!data || typeof data !== 'object' || Array.isArray(data)) {
    return null;
  }
  return data as T;
}
