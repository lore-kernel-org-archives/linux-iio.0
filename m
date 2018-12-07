Return-Path: <SRS0=POtY=OQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA57C64EB1
	for <linux-iio@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6B4208E7
	for <linux-iio@archiver.kernel.org>; Fri,  7 Dec 2018 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj1syd19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6B4208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLGOuJ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:50:09 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:33678 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeLGOuJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Dec 2018 09:50:09 -0500
Received: by mail-pg1-f170.google.com with SMTP id z11so1840030pgu.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Dec 2018 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ki3ta2M2pDqPD7aP4r4svTp8M3mqQ3Vm8QhhFshSx88=;
        b=Vj1syd19ZeJobkR12G6R6pDvfgrmBZBboeB4me6heMGFpg3zhcvS8cBkFmu0RRApkR
         X6SzrC3NUhieB8oy6YopOyRKnBhdU6R5ItbIQVSY8n4tB0QEP1NVuOR4cDvA5PCPRgV0
         AqQnfo1qttqPyAtvf4UVZyr1Qd/+BPkVhAgnpkP9qV6JDkuOiviXX2eCgIK2n/LoQtlf
         2e4FLlKl4C31aH3kLheb06kfVjuAD6AZbO65XECiqZA+ZTol0nuaLY59QYpRfQs3Ywue
         Nbo9nIny+deozu3zwUaRxkwO2yXKBxZOZ9ats+v2Rn80qTGDfSVWHrCtrYRK2VLqn89G
         AZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ki3ta2M2pDqPD7aP4r4svTp8M3mqQ3Vm8QhhFshSx88=;
        b=dxx34Nlw8f/z62itbbXsi7YNK2UJneUbFaJMR1NecKImPjl7niv51vX5h1SG0yEkXk
         SQJgAm9mWjbopejWSVZdjOa1MyYODQOSV5ruaJVnnIMnY/0J/H5Nr7EGeIxTSXdzBdQ0
         oUC/L+48pL0ppgfP5bPiYIrJyH2OmGEcuUnvPGz4MFYZbBcAY9hyn8FPKQ5d7B/5hosF
         3peygRMj+BTKHb9W+IX9nD6ZFXB/nX10v3KL8VoL/+vGZhg+7I9M4p9s2wiF/eA5jt7n
         UlHKs4/pxtbA+grUqhcvJh67SCToVKOwVfeVCe+zxuzIcUAG3UZoMcOvsLheME0I447R
         ug+g==
X-Gm-Message-State: AA+aEWZxrM14xaXOvgZLSqkDmRvrtIy5k6tHS7qSUBIvmtlRgLzORBQ2
        iN4m0tft39K4q10bQ4AOm9cBEWH6
X-Google-Smtp-Source: AFSGD/XSom8d7eLYiX8CwPUQX3fQdQ0U3qpswvzGFwzXevHkoU1Pe+4snU8Uv5+dd9z+tRW+g1UVpA==
X-Received: by 2002:a63:e84c:: with SMTP id a12mr2162633pgk.241.1544194207550;
        Fri, 07 Dec 2018 06:50:07 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id v5sm9433082pgn.5.2018.12.07.06.50.05
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 06:50:06 -0800 (PST)
Date:   Fri, 7 Dec 2018 20:20:00 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     linux-iio@vger.kernel.org
Subject: [ANNOUNCE] New IIO mailing list archive
Message-ID: <20181207145000.GB2023@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,


IIO has a new archiving website with all permalink and search
support etc., at https://lore.kernel.org/linux-iio/

Pretty much it will be the "official" kernel mailing list in future
and

YES
	https://lkml.kernel.org/r/<MSG-ID>

does direct to lore archive (previosuly it used to direct to marc.info?)

Big shout out to our LF IT/Security Buoy a.k.a Konstantin Ryabitsev for
archiving the list and Jonathan Cameron for the donations $$ ;)

	(Konstantin is the one behind the pr-tracker-bot system ..)



Namaste _/\_
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
