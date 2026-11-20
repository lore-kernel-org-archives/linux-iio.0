Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155576;
	b=UCeZRkZYtuDgS33TmdO6Cnr8+6r+c7v57DVIz022p6NaF+lBQK7fVqqd/Ne6NL19rMhS
	 ulK+7auJ5wo44c9XqYjvhBl+lF/x9gyz7bNwatPrBUsHZ33BUUcZKgKPAX+wirDzqEIfq
	 pUlEWIcOWKUyybqvw+7zKmFry2hfT68tcBh41IS7kJM8IeKBdBREH7Ih7zfoatr3Fs2Eo
	 BLGWWnnqDNDoOnBtR0NbhhL79cVV5B1xa81D5ejJchJL6cFx8PTgW4BsFCmsSEc/puTi2
	 c/TGpFlPk3qav3pWV0OFlqwiBNOzy154c82Bc/escOyKsPmjWUp85IoH1UW/kbzca4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155576;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UMPAAPCLzBbunUcT6MmbMgRt2fo0cikfaElaMhtPopw=;
	b=WqyyBUWGz5J75eNYwuOzjicjHrT26gefOLqrejBI5eXCA25dUxF9rLwVeUs1cLY2c30I
	 Ryv2WbAKOj/ryv5CqqcdL0bzR/lipVDEvmfNUAP2Dnzw9ADIEScrmk9yXZV47oQxzXAf0
	 lcLYDP1W4AmiinvRzTyhdUnIWiYj++MiXo2mvjLtDuW9R0SOdk9t6FOA2N6QKTt2qQSlJ
	 Hanj9TcsvyC10YhBYAVRN1tWZR6/ESK+7hafKTgFNEVyUNQ7QhjuLg4lxtN30+3gqy+Ao
	 7/IlZMC/DcJ1R2QWvsEgY/qKsZZWF9y3aWtPNYCYD+OAOjVaeKHdSv+2BqjvWtB2gEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=sdijcHVx;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC24606A33E;
	Fri, 20 Nov 2026 06:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC24606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=sdijcHVx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=sdijcHVxoJdHBHku1a7tWK2CxURpotA9TSJDgTuPzaLHBzSehNCnZdm47NQuUxnHAWkv5qX3/6B5V
	 qg9LVHirl5kkHnc6iUfy77xFweOFBaxjMVc0JBXEcYKxgNeYMpxPPhikOY7FjBV/K87ES8MALgz4N3
	 mEmHY18kwg0OAeGQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76affe674aae-25af1;
	Fri, 20 Nov 2026 14:19:33 +0800 (CST)
X-RM-TRANSID:2ee76affe674aae-25af1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76affe6741b0-181a0;
	Fri, 20 Nov 2026 14:19:33 +0800 (CST)
X-RM-TRANSID:2ee76affe6741b0-181a0
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: fabrice.gasnier@foss.st.com
Cc: wbg@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/counter: Reject invalid watch fields before narrowing
Date: Fri, 20 Nov 2026 14:19:32 +0800
Message-ID: <20261120061932.98210-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The channel, component ID and parent fields are all eight bits wide.
The current parser accepts trailing characters and silently narrows
values above 255, which can select the wrong counter watch. Parse
these fields before assignment and only accept a value in range.

Fixes: 1e73427f6635 ("tools/counter: add a flexible watch events tool")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/counter/counter_watch_events.c | 51 ++++++++++------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
index 15e21b0c5ffd..432a0cb9d300 100644
--- a/tools/counter/counter_watch_events.c
+++ b/tools/counter/counter_watch_events.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <stdlib.h>
 #include <stdio.h>
+#include <stdint.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
@@ -288,44 +289,28 @@ int main(int argc, char **argv)
 					watches[i].event = ret;
 					break;
 				case WATCH_CHANNEL:
-					if (!value) {
-						fprintf(stderr, "Invalid chan=<number>\n");
-						rc = EXIT_FAILURE;
-						goto err_free_watches;
-					}
-					watches[i].channel = strtoul(value, NULL, 10);
-					if (errno) {
-						perror("strtoul failed: chan=<number>\n");
-						rc = EXIT_FAILURE;
-						goto err_free_watches;
-					}
-					break;
 				case WATCH_ID:
-					if (!value) {
-						fprintf(stderr, "Invalid id=<number>\n");
-						rc = EXIT_FAILURE;
-						goto err_free_watches;
-					}
-					watches[i].component.id = strtoul(value, NULL, 10);
-					if (errno) {
-						perror("strtoul failed: id=<number>\n");
-						rc = EXIT_FAILURE;
-						goto err_free_watches;
-					}
-					break;
-				case WATCH_PARENT:
-					if (!value) {
-						fprintf(stderr, "Invalid parent=<number>\n");
-						rc = EXIT_FAILURE;
-						goto err_free_watches;
-					}
-					watches[i].component.parent = strtoul(value, NULL, 10);
-					if (errno) {
-						perror("strtoul failed: parent=<number>\n");
+				case WATCH_PARENT: {
+					long num;
+					char *end;
+
+					errno = 0;
+					num = value ? strtol(value, &end, 10) : -1;
+					if (!value || end == value || *end || errno ||
+					    num < 0 || num > UINT8_MAX) {
+						fprintf(stderr, "Invalid value for %s\n",
+							counter_watch_subopts[ret]);
 						rc = EXIT_FAILURE;
 						goto err_free_watches;
 					}
+					if (ret == WATCH_CHANNEL)
+						watches[i].channel = num;
+					else if (ret == WATCH_ID)
+						watches[i].component.id = num;
+					else
+						watches[i].component.parent = num;
 					break;
+				}
 				default:
 					fprintf(stderr, "Unknown suboption '%s'\n", value);
 					rc = EXIT_FAILURE;


