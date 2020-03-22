Return-Path: <SRS0=ud0C=5H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E976C4332B
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 19:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626D820719
	for <linux-iio@archiver.kernel.org>; Sun, 22 Mar 2020 19:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVOWD3+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgCVTyU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:54:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCVTyU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Mar 2020 15:54:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id j1so3684924pfe.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2020 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/rQmKX0XdBt7pgAhTvraA8XGz+IqOTJZGXuwXaH9V4=;
        b=cVOWD3+iu9cLu8Lrk1PJiZ6vFi9ssNFMzMXk9FMX6JlNIZYsJgjJY1CsazofylfVbn
         t0YfSOsNPgFqQj+NcC2UvHyyOI4uQuGO72cJtnxdFVnGTuF8kWCcnijW44u7baYubzPA
         zWj4OcW+1PGRx1j1OBtFqvtn29GdLv/QLl00BN5WmEOVB4ERwM9OGTi1pRn0rhsbBY9U
         JZ92bGgcq4QUjhZTSRXyw+unfovaVgTDsz1Z12b5vkjaRk7+/S2Ke7kCO8gST8kvkzck
         0bFcjs0H2iqhasmUFU3PmrR5ggcTXOHwOzenKIFr1btCii5yBrhTXZAmVN0eIigIHxUY
         +KGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/rQmKX0XdBt7pgAhTvraA8XGz+IqOTJZGXuwXaH9V4=;
        b=giA7y5TOtBVWRYGWp8nd9UfwummJUOc5RiTvM+7NtTgJuRLrGouM3Scb0sRmyGLyTu
         UGQTWmw5vokoafF7Kw9FTKhfeYs/41lxSP2Uch46oYIwFHg7K1r+WTmYgt+okh0Z0TPG
         uMHIv5sc/uT312c5V06sBNAK4TXyFPRUHRtaSv4CI8KygbC6wPvSihkE85lytQnUuJg1
         1E/5yDt2iomdqXnvNw6r5HE7tjXgRlerRVot1+IEhmpMh4j/a+FkMj3VjzhTDHZWa7hj
         l6gUcQ0Lz3MSxPMrPUK3On2ph2Z1WFfI32FCC6Py7TBhvPp9Bh8VXNOaLTW5FmOpthrb
         FBPQ==
X-Gm-Message-State: ANhLgQ3fMUkqhBSAxdOFjMKiCWgr9f/RNZ3uIKk6YPWitziIMIrcDsJB
        wURJmaG6d7Uhsk3Ur81MRC0=
X-Google-Smtp-Source: ADFU+vtFuD5Yqy5uCDWudJZHEEorQEawZybLCok0GUJ2TB0WggeljPQgiWUfqxRTUwk0hpK7IuCp8w==
X-Received: by 2002:a63:7359:: with SMTP id d25mr17991902pgn.2.1584906859588;
        Sun, 22 Mar 2020 12:54:19 -0700 (PDT)
Received: from deeUbuntu ([103.240.207.191])
        by smtp.gmail.com with ESMTPSA id b16sm3463815pfb.71.2020.03.22.12.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Mar 2020 12:54:19 -0700 (PDT)
Date:   Mon, 23 Mar 2020 01:24:13 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v3 1/4] staging: iio: adc: ad7192: Re-indent enum labels
Message-ID: <5c6bef6462d135b748f58f8c2645c60234482f52.1584904896.git.mh12gx2825@gmail.com>
References: <cover.1584904896.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1584904896.git.mh12gx2825@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Re-indent enum labels as per coding style guidelines. Problem
detected by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---

Changes since v2:
	- None. Version number increment to follow patch series version.

Changes since v1:
	1. Separated other change into a separate patch as suggested by
	   Greg KH.


 drivers/iio/adc/ad7192.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8ec28aa8fa8a..02981f3d1794 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -157,8 +157,8 @@
  */
 
 enum {
-   AD7192_SYSCALIB_ZERO_SCALE,
-   AD7192_SYSCALIB_FULL_SCALE,
+	AD7192_SYSCALIB_ZERO_SCALE,
+	AD7192_SYSCALIB_FULL_SCALE,
 };
 
 struct ad7192_state {
-- 
2.17.1

