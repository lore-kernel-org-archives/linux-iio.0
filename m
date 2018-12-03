Return-Path: <SRS0=fsUv=OM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A89C07E85
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 11:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1A20848
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 11:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Poe7TRDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbeLCLff (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:35:35 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:33108 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbeLCLfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Dec 2018 06:35:34 -0500
Received: by mail-wm1-f46.google.com with SMTP id r24so6752014wmh.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Dec 2018 03:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rBkFXOg23Gau/VI9+SAGYUJ7hE0y+HGgpzMb1MFoRP0=;
        b=Poe7TRDpWMu4iMvIIEG9EXd+RojoktJmaGJd6e4AGZniXRl/p1txulruGjc1kq+0Rt
         +P3Xp2StwKSV67QWq/d3EK/sc88XsppS33YMAyQ/AzlqQ9ecCOqFVrMBWfC42L0RV2Hs
         Z4RdLtV8uDVuS8WySxUsk8xD/BmBhu1Gay3Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rBkFXOg23Gau/VI9+SAGYUJ7hE0y+HGgpzMb1MFoRP0=;
        b=nxo0TDUycK9JQ8Pffa3HEejodblvaDUk12pigO+MJZ+HcSeEjBVoYvHhp9iBdAK123
         8gNLV2r1ENL8vxbMJPcK5fVu1aiNNI2+bujUd54XvlCrD2SJs9c4FlS9u0mw0qVA8Ltb
         oQalGurJW6M3E2t20lwJx10kb3h1GU6yFbAa2YNE+3MKw4JD4T8uq2ZPvdPZkY1FmWvX
         c1riS9Q7sEXCz7d6LzU4lTKmQ+tA2MDIECyu/svCxeKz9yzbj87Z7r9m09d6LN9cL3VX
         NV1euKtOuJ1WU7klEg5WltkJOQvcskMFhAnkZZlRLydcPBK44zLLhXHLQzM9yVKoQMTB
         V1gw==
X-Gm-Message-State: AA+aEWbtyi3MReSqIhB2VHs5iRUgiBwOuKOXFEd3/90reHHaHuojrrkz
        A8qDU9ePkJJeRrl+08rVbIZBSicl2hg=
X-Google-Smtp-Source: AFSGD/V+gq12fvuZnWIfpJdjUIfgGK7SlvwMh2OP8Hpocp7jvubfZ2LkEqByc6zwvHSEKx1mzbUvcA==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr7455236wmd.151.1543836892940;
        Mon, 03 Dec 2018 03:34:52 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id y13sm8992722wrw.85.2018.12.03.03.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:34:52 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:34:50 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and IIO due for the v4.21
 merge window
Message-ID: <20181203113450.GM26661@dell>
References: <20181203080118.17504-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203080118.17504-1-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Enjoy!

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-v4.21

for you to fetch changes up to 4b3ab9372ffa569827c8f7b7ffc7b69ba544a3bd:

  iio: adc: ti_am335x_tscadc: Improve accuracy of measurement (2018-12-03 11:33:20 +0000)

----------------------------------------------------------------
Immutable branch between MFD and IIO due for the v4.21 merge window

----------------------------------------------------------------
Vignesh R (2):
      mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO while registering mfd cells
      iio: adc: ti_am335x_tscadc: Improve accuracy of measurement

 drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-
 drivers/mfd/ti_am335x_tscadc.c       | 5 +++--
 include/linux/mfd/ti_am335x_tscadc.h | 4 ++++
 3 files changed, 11 insertions(+), 3 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
