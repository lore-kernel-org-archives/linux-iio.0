Return-Path: <SRS0=zyAD=Q5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852EFC43381
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFD12070B
	for <linux-iio@archiver.kernel.org>; Fri, 22 Feb 2019 20:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="pmL/RAit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfBVUcO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:32:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37768 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBVUcO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Feb 2019 15:32:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id m9so1948200qkl.4
        for <linux-iio@vger.kernel.org>; Fri, 22 Feb 2019 12:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMvWhJJIWwEWAvqHUZnz1E7GfbdI3HbVyTUd87lOV4g=;
        b=pmL/RAitCh2BmWIo52qGaXLT1oh9760eZ+hcN+cqIIAukb/TTYVgzRBldf8m2hitmF
         J2Eyne+pbIWLNHq1ejb4G2/ZTCYfBW4a7b/bpjfC2yBJr0DywB6JnG4/KdPGLYNNjBHu
         tZxFtQuQ6iOQL/KSje7R/aHKMnn0PPyd6/LhexiHAYU3Ob3KSyYTJFWkWAydUKEUVO7p
         1dupSguguAOJgFhlKrCuCb4sKs2Z+9NY64ebMV06O2ZE2LmlOHN1x3OSV97LkFXppkd4
         gsnkssmNuzPIlVG0L9H83hJElzuJYmx1Wgik4q8WDkzWzpVoqszjXojuKSmpfizgzojv
         7LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMvWhJJIWwEWAvqHUZnz1E7GfbdI3HbVyTUd87lOV4g=;
        b=iAflLmmuUN/1QE5L0Gx8b3JXJmp/jSf+RvkG+UqZmKIn8Z4TdCrR+oTdsu4VdUVUCD
         h0O2ARS+NjmFS3N3RR7Sx+l/4fmiRwCAV9po1FggPicZq2bJ+scnztmklQPRKxRJDHE2
         ojzX9hOC3xEv3BiN3hfTw784Ch729HJH46y9UJZN8t+mUn1LRFWF3VqFV591nT3Zz8Yw
         KoZbd1vqwoC75bYPR7Wlu6DAN199Q0xulLh33w9gBeKS8maD3MF0TcQ8UJhxOHiCwr6b
         H29sgUH3Z+Z5+oKYLv6IJKWvJs3/+jqaiZ0cLGj7ieVcZ8EyzcXr1+KonGmrCe+mO1a1
         4ZWA==
X-Gm-Message-State: AHQUAuZY52lprTdH5kK4pBr150YASNkOTbyJcg4m9IYMF+dSWZK1R77n
        kr3cJowaf2uhFMjC4RKhPtXdug==
X-Google-Smtp-Source: AHgI3IZnDZWoz7A3OEiLUdxVah047+pBg/quyL6cJnsXw/BGpBVW8BrsLG87yIqF5t+EdW1i4NDyFg==
X-Received: by 2002:a05:620a:1310:: with SMTP id o16mr4443591qkj.191.1550867533382;
        Fri, 22 Feb 2019 12:32:13 -0800 (PST)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v26sm1449149qtk.22.2019.02.22.12.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 12:32:12 -0800 (PST)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
Subject: [PATCH 0/4] Solve checkstyle problems 
Date:   Fri, 22 Feb 2019 17:31:55 -0300
Message-Id: <20190222203159.15116-1-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Solve checkpath.pl's CHECK messages:

Bárbara Fernandes (4):
  iio:adc:ad7923: Align broken line to parenthesis
  iio:adc:ad7923: Use BIT macro instead of bitshift
  iio:adc:ad7923: Put macro argument between ()'s
  iio:adc:ad7923: Rewrite comparison to NULL

 drivers/iio/adc/ad7923.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.17.1

