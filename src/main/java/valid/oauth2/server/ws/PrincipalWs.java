package valid.oauth2.server.ws;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
public class PrincipalWs {

    @GetMapping("/user/me")
    public Principal user(Principal principal) {
        return principal;
    }
}
