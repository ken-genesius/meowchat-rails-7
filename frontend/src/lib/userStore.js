import { create } from 'zustand';

export const useUserStore = create((set) => ({
    currentUser: null,
    isLoading: false
}))