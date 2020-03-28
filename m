Return-Path: <SRS0=BGF5=5N=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97B1C43331
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 06:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E05420748
	for <linux-iio@archiver.kernel.org>; Sat, 28 Mar 2020 06:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzWF77hz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgC1GxK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 28 Mar 2020 02:53:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45870 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgC1GxK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 02:53:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b9so4371506pls.12;
        Fri, 27 Mar 2020 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=oysS4IODwhNBmluxos+XgcJbFMUuCi3+UiQxsMsgdkc=;
        b=LzWF77hzCiePKECDaEDwsZDkYM8emrvGkFsmkld0GA29731CgJsp/IAKgMigYIBEa8
         MisAaYpR0FJYo4O1yN/izm0bXRve+LOBVr5Nw4xMckcMdc9N6GEZIoW1xNgEya+8JdjF
         dc50e1umN9t7CXsZdznG3oKU9NQbC6cMv2s8ZtqnyWW/X0d6kDDZs0d2bCGZYe06ndR/
         G0Dcdrxg+1F1BjpB7qoK5BEbuLTphfHy5R65tNnYvddHzwVsWxsfbtgemD2EeKyiq2xk
         fGMWbSrEvDIouhZ3s6GyXvz/69K56y3HD+s5zvLw5AdgewwvwVd1jHpIi/5P2em84AjH
         htAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=oysS4IODwhNBmluxos+XgcJbFMUuCi3+UiQxsMsgdkc=;
        b=cHsKGENxXGwiasU5mlSLzas8NH0KcC9LiPhjMkCZ/sIwutzDsCC6gqqSvYY4bziY9L
         NcNp6KGzL7Zy2UkqudFNhjiQrg2M/ZT9Wq3cAPwuCeeYmflVfcuQRFgj9ShfQlFfD331
         seYFtiPyU9GCkdfKPSBlI1Ink4d5aPgtCujSQnK/acSSrf71H807YZi5zDyDij6NKobO
         qQ3y/GZH5TSjXo91fwOMgWF9lEAZxPWYUrpcbqMMABGY2hIGphq4lzS+/I699B8GouRW
         Rtxzcnri2IavzT5DMy50FJ3G6xxQd71MiadbFALyj0SGwYjWMjk0XAO6Q6wfWok1+EX6
         ygrA==
X-Gm-Message-State: ANhLgQ2sSJN9wLtMACGCBM6lqeUcV9XypqVe0cEqn891D3lkQNMMqR96
        PJh/ze5tUsEFomr080ntCl3UugjXGDA=
X-Google-Smtp-Source: ADFU+vsGykiRiJ5ZnCPYz3gP4mv0YRe5fF9YK+m+6oOJte+5l5wRo0nP4wDacuWubEfzvhgkl0PXLg==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr3595685pjq.10.1585378388828;
        Fri, 27 Mar 2020 23:53:08 -0700 (PDT)
Received: from SARKAR ([106.51.108.92])
        by smtp.gmail.com with ESMTPSA id 11sm5464738pfz.91.2020.03.27.23.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 23:53:08 -0700 (PDT)
Message-ID: <5e7ef454.1c69fb81.56770.82c7@mx.google.com>
X-Google-Original-Message-ID: <20200328065144.GA29906@rohitsarkar5398@gmail.com>
Date:   Sat, 28 Mar 2020 12:23:04 +0530
From:   Rohit Sarkar <rohitsarkar5398@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        rohitsarkar5398@gmail.com, jic23@kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        dragos.bogdan@analog.com
Subject: [PATCH] iio: temperature: ltc2983: remove redundant comparison to
 bool
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Remove redundant comparison to a boolean variable.

Fixes coccinelle warning:
drivers/iio/temperature//ltc2983.c:393:20-32: WARNING: Comparison to bool
drivers/iio/temperature//ltc2983.c:394:20-32: WARNING: Comparison to bool

Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
---
 drivers/iio/temperature/ltc2983.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index d39c0d6b77f1..8976e8d59826 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -390,8 +390,8 @@ static struct ltc2983_custom_sensor *__ltc2983_custom_sensor_new(
 	 * For custom steinhart, the full u32 is taken. For all the others
 	 * the MSB is discarded.
 	 */
-	const u8 n_size = (is_steinhart == true) ? 4 : 3;
-	const u8 e_size = (is_steinhart == true) ? sizeof(u32) : sizeof(u64);
+	const u8 n_size = is_steinhart ? 4 : 3;
+	const u8 e_size = is_steinhart ? sizeof(u32) : sizeof(u64);
 
 	n_entries = of_property_count_elems_of_size(np, propname, e_size);
 	/* n_entries must be an even number */
-- 
2.23.0.385.gbc12974a89

