Return-Path: <SRS0=kvxZ=PY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF9C43444
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1217E20657
	for <linux-iio@archiver.kernel.org>; Wed, 16 Jan 2019 12:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqyNUgd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390377AbfAPMo2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:44:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38906 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732814AbfAPMo1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2019 07:44:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so6771619wrw.5
        for <linux-iio@vger.kernel.org>; Wed, 16 Jan 2019 04:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YI/hMv2Ykfpzsha58avQfgbQuOAe4wiKzvr58KA+C/4=;
        b=bqyNUgd0gfeRk1x1ONPXAxtmtgtkVIZQ4vTcWAaR4cjSIbk6sbAjhEa4a8gAFmSTUm
         0WTosVm+mjFAcid3iCNfaYDVE85/dPnxvAGRy6vrfRCe9YbtgvjeIalIoORPHXVtv2xE
         IUZ3c0unFCSlNppo8UYeXEZsDPlqoskBmxb30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YI/hMv2Ykfpzsha58avQfgbQuOAe4wiKzvr58KA+C/4=;
        b=VK998Gih5LvjHQrPGq5oBlQdn7iYYNK1wwDZtcpFdQLNjcPwgDrUg1zQraXmCNfZEF
         3ISQVBFthLKY9ya+Tyg1/gy8MrTXb2Ujc7RragiXbQ6qVLe3+bmhHhAGUhm2kOsWseW/
         5eLyhMEDGrDG7ZDHTRBxAKp9oDhX0ciNH/GDzphZrjLfBEd2BK7TD45tk0+Rq2vivQ4z
         3chnqogYgEf7h3Yeesf78OfwsOxS31uBvRAlbtuMzNHDLdRhZIkxUIOrdUBXLJCPXxkP
         j5HE1CWDDfr8bNe2u5lU2rOOWUO01tlpkHn22u687RJc9sYKbt+YlBs/1+DDtraSwfn7
         73Sw==
X-Gm-Message-State: AJcUukdu1MVfhLyY+iZQG47FpjkkhNyr5HZlFfM82krCD4pzxOI/ptuV
        rCINyq2/Fx7/iChKaqom5ofc7Q==
X-Google-Smtp-Source: ALg8bN6DdBq+X2nTLgwh2v+QzLpv9b8DGxQUfKcMDxj2cVxfqvcPm3IOUOrAn3yXMgVZdzcsdlxr9g==
X-Received: by 2002:adf:e407:: with SMTP id g7mr7222174wrm.277.1547642664949;
        Wed, 16 Jan 2019 04:44:24 -0800 (PST)
Received: from dell ([2.27.35.149])
        by smtp.gmail.com with ESMTPSA id f130sm33103811wme.41.2019.01.16.04.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 04:44:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 12:44:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch,
        robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org,
        dmitry.torokhov@gmail.com, thierry.reding@gmail.com,
        digetx@gmail.com, coquelin.stm32@gmail.com,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Freeman Liu <freeman.liu@spreadtrum.com>,
        linux-input@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v5.1 merge window
Message-ID: <20190116124421.GD23399@dell>
References: <20181221134638.20600-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Taken all but the ARM patches.

These need to be reviewed and go in via ARM-SoC.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v5.1

for you to fetch changes up to 81cdab79818988d27d8aeb162b7988c9e6dde936:

  iio: adc: add STMPE ADC devicetree bindings (2019-01-16 12:37:36 +0000)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v5.1 merge window

----------------------------------------------------------------
Philippe Schenker (3):
      dt-bindings: stmpe: Reformatting parameter list and use tabs only
      mfd: stmpe: Move ADC related defines to MFD header
      Input: stmpe-ts: preparations for STMPE ADC driver

Stefan Agner (3):
      mfd: stmpe: Preparations for STMPE ADC driver
      iio: adc: add STMPE ADC driver using IIO framework
      iio: adc: add STMPE ADC devicetree bindings

 .../devicetree/bindings/iio/adc/stmpe-adc.txt      |  21 ++
 .../bindings/input/touchscreen/stmpe.txt           | 116 +++++--
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  28 +-
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/stmpe-adc.c                        | 363 +++++++++++++++++++++
 drivers/input/touchscreen/stmpe-ts.c               |  66 +---
 drivers/mfd/Kconfig                                |   3 +-
 drivers/mfd/stmpe.c                                |  68 ++++
 include/linux/mfd/stmpe.h                          |  21 ++
 10 files changed, 610 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 drivers/iio/adc/stmpe-adc.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
