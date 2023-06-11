Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1B1C7EE2F
	for <linux-iio@archiver.kernel.org>; Sun, 11 Jun 2023 20:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjFKUfV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 11 Jun 2023 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKUfU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Jun 2023 16:35:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C382E4E;
        Sun, 11 Jun 2023 13:35:16 -0700 (PDT)
Received: from i53875b22.versanet.de ([83.135.91.34] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1q8RmL-0005fi-Em; Sun, 11 Jun 2023 22:35:13 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     sebastian.reichel@collabora.com, conor+dt@kernel.org,
        Shreeya Patel <shreeya.patel@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        serge.broslavsky@collabora.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org,
        gustavo.padovan@collabora.com, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: rock5b: Add saradc node
Date:   Sun, 11 Jun 2023 22:35:11 +0200
Message-Id: <168651570335.1681170.7335757398130366912.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230610134841.172313-1-shreeya.patel@collabora.com>
References: <20230610134841.172313-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 10 Jun 2023 19:18:41 +0530, Shreeya Patel wrote:
> Add ADC support for ROCK 5B.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: rock5b: Add saradc node
      commit: 2fe1f20144fb68dd31798cc22a67d148f517deef

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
