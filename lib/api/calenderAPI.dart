ackage api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * MessagingAPI simulates sending messages between users and clubs.
 * Designed for integration with the Club Connect app.
 */
public class MessagingAPI {

    // Simulated message storage: clubId -> list of messages
    private Map<String, List<String>> messages = new HashMap<>();

    /**
     * Send a message to a club
     * @param clubId the club identifier
     * @param message the message content
     */
    public void sendMessage(String clubId, String message) {
        messages.putIfAbsent(clubId, new ArrayList<>());
        messages.get(clubId).add(message);
        System.out.println("Message sent to club " + clubId + ": " + message);
    }

    /**
     * Retrieve all messages for a club
     * @param clubId the club identifier
     * @return list of messages
     */
    public List<String> getMessages(String clubId) {
        return messages.getOrDefault(clubId, new ArrayList<>());
    }
}