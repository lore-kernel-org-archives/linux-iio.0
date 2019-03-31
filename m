Return-Path: <SRS0=bx8B=SC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C3CC43381
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07862086C
	for <linux-iio@archiver.kernel.org>; Sun, 31 Mar 2019 14:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mrs.ro header.i=@mrs.ro header.b="ylsUYiVP";
	dkim=pass (1024-bit key) header.d=mrs.ro header.i=@mrs.ro header.b="BMEMgFi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731243AbfCaO7o (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 31 Mar 2019 10:59:44 -0400
Received: from mrs.ro ([109.74.194.28]:54114 "EHLO mrs.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbfCaO7n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Mar 2019 10:59:43 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Mar 2019 10:59:43 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mrs.ro (Postfix) with ESMTP id CE908619C
        for <linux-iio@vger.kernel.org>; Sun, 31 Mar 2019 17:54:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrs.ro; s=mail;
        t=1554044052; bh=BAGNfDWPA8hHgjTRn0pDWPuRFNLDZnNq2pyrpCMyf5M=;
        h=Date:From:To:Subject:From;
        b=ylsUYiVPzdyC3/fZtz60q8ZM+/7B0gaq3EayPbcVnq9AH/LpXf3l7yxW2EawzPj9w
         dy4LOigENXqhpZLB0WBjn//Cy9v7yZ7lcnzG2XB7W6WS70XdXxojOwK3tQkFwbcajD
         50vlvbyeBsdWuGAiszIGT3kMm8RS9s5u0jNIBJSA=
Received: from mrs.ro ([127.0.0.1])
        by localhost (mail.mrs.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hv4MRZtSHqyA for <linux-iio@vger.kernel.org>;
        Sun, 31 Mar 2019 17:54:09 +0300 (EEST)
Received: from mail.mrs.ro (localhost.localdomain [127.0.0.1])
        by mrs.ro (Postfix) with ESMTP id 74B7A6078
        for <linux-iio@vger.kernel.org>; Sun, 31 Mar 2019 17:54:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mrs.ro; s=mail;
        t=1554044048; bh=BAGNfDWPA8hHgjTRn0pDWPuRFNLDZnNq2pyrpCMyf5M=;
        h=Date:From:To:Subject:From;
        b=BMEMgFi+x+Wq4vd6+cCRw7YJbJYQhv3tb2/inCTzH5QInsxfHSd4QGMWg0oXxapy8
         Qytd+2It6C9uLlu0Py5A9vGEjzh4tLGshe09X5G4cFEPERtyNBdeCpIVbxuYx31mEh
         QGyJupkiptuuBZXVagBVlbQEMr5Ia0nGhB+Nu/Q8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 31 Mar 2019 14:54:08 +0000
From:   Valentin Manea <linux-iio@mrs.ro>
To:     linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: kxcjk1013: Add KIOX0008 ACPI Hardware-ID
Message-ID: <abfff08c719e6da87b6fd029d4f985e8@mrs.ro>
X-Sender: linux-iio@mrs.ro
User-Agent: Roundcube Webmail/1.3.0 
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the ACPI ID for KXCJ9 sensor seen on the a Teclast X80 Power
tablet.

Signed-off-by: Valentin Manea <linux-iio@mrs.ro>
---
  drivers/iio/accel/kxcjk-1013.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c 
b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b..aecf629ba 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1489,6 +1489,7 @@ static const struct acpi_device_id kx_acpi_match[] 
= {
  	{"KXCJ1013", KXCJK1013},
  	{"KXCJ1008", KXCJ91008},
  	{"KXCJ9000", KXCJ91008},
+	{"KIOX0008", KXCJ91008},
  	{"KIOX0009", KXTJ21009},
  	{"KIOX000A", KXCJ91008},
  	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 
*/
-- 
2.17.1

