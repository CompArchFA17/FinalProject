
class LRUCache {
public:
    unordered_map<int, int> val;
    unordered_map<int, int> freq;
    queue<int> q;
    int cap;
    

    LRUCache(int capacity) {
        cap = capacity;
    }
    
    int get(int key) {
        if (!val.count(key)) {
            return -1;
        }
        
        q.push(key);
        freq[key]++;
        return val[key];
    }
    
    void put(int key, int value) {
        val[key] = value;
        q.push(key);
        freq[key]++;
        if (freq[key] == 1) {
            cap--;
        }
        while (cap < 0) {
            int last = q.front();
            q.pop();
            if (freq[last] == 1) {
                freq.erase(last);
                val.erase(last);
                cap++;
            }
            else {
                freq[last]--;
            }
        }
    }
};
