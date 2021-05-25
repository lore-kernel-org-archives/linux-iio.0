Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A816C47085
	for <linux-iio@archiver.kernel.org>; Tue, 25 May 2021 12:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE196142B
	for <linux-iio@archiver.kernel.org>; Tue, 25 May 2021 12:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbhEYMZ3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 25 May 2021 08:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232281AbhEYMZ2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 May 2021 08:25:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D713E613F5;
        Tue, 25 May 2021 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945438;
        bh=GIEJxGG9nxCY0eLF6InjggDcNAM0Z1TTWf2XzhFZ2Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ocw3Ch+xcvD1urzl6kjoUgUOlVdP57hgn4W3afKXGQJ8sc3YuBiFXWdAuLxx/e96V
         JkBadg5YDJVFQnZodh4uBt/1UVJiBH6afeFOzLxFvbF+LAUI8vkmtIcTcCXLD7oKGk
         BDQSmJvHhTz4WvHdvi4JWHOVVDd5BdkbWOgd4YXKmm27HWHbOcV0PCmaxbdomPu2O8
         Ahi3uWKAr37UASWNKaXJZ53zuxF0WcF0P43QS0PcbMjvshRypYUYd+Xl4CdoL/Ybyq
         /T4SQFJW6UbbU9seUJWUmN2Potjb0Vood+qQBNprAAh8SYnD9jovhPuJLiMB8yXFfd
         knv888BlOVZLw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1llW6G-000tUA-K4; Tue, 25 May 2021 14:23:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: ABI: sysfs-bus-iio: fix a typo
Date:   Tue, 25 May 2021 14:23:52 +0200
Message-Id: <fa90a2deebac80da42b1ad4cf570c4ace436577d.1621944866.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621944866.git.mchehab+huawei@kernel.org>
References: <cover.1621944866.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Descrption -> Description

This causes some errors when parsed via scripts/get_abi.pl.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-iio | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 267973541e72..433fe0ab74be 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -786,7 +786,7 @@ What:		/sys/.../events/in_capacitanceY_adaptive_thresh_rising_en
 What:		/sys/.../events/in_capacitanceY_adaptive_thresh_falling_en
 KernelVersion:	5.13
 Contact:	linux-iio@vger.kernel.org
-Descrption:
+Description:
 		Adaptive thresholds are similar to normal fixed thresholds
 		but the value is expressed as an offset from a value which
 		provides a low frequency approximation of the channel itself.
@@ -798,7 +798,7 @@ What:		/sys/.../in_capacitanceY_adaptive_thresh_rising_timeout
 What:		/sys/.../in_capacitanceY_adaptive_thresh_falling_timeout
 KernelVersion:	5.11
 Contact:	linux-iio@vger.kernel.org
-Descrption:
+Description:
 		When adaptive thresholds are used, the tracking signal
 		may adjust too slowly to step changes in the raw signal.
 		*_timeout (in seconds) specifies a time for which the
-- 
2.31.1

