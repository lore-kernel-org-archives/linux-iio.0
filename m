Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF811E7D0AB
	for <linux-iio@archiver.kernel.org>; Thu, 21 Sep 2023 22:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjIUWLM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjIUWKz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Sep 2023 18:10:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6084F3E;
        Thu, 21 Sep 2023 10:37:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91A2C4AF7B;
        Thu, 21 Sep 2023 11:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695297053;
        bh=mXYzQ1Aw2AmUUG7pVcJYPh5w/95BLX6Xyx+iv32GdjM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Bs2WggFziPp0qrw2QPhcDrEk2iWOjqSQHn7c+YlHM/5kRBfSCxdlUXbYPM5UknYKM
         t75jJJqXm4wRyg2gGjrsZtyfooghoz7C/bJOP6/zSOwkA2uLsJAsPXMsYpmN6JLVGw
         8MFNURKRlvcipijmnRr+i+K1ab4Ofk3AybcxouKfYlng1S5z8qvNnw4jQO4R+gw0Er
         YmJqw+V2ZTRUIQ3RGeelZr92fzcpWFmM4+xp5Q8/pu48a0hfIPiN0rvRAeipckKMaK
         CQZPD0H6T10DUVULVf9Ud3NZenXyl4qlByMEHHXZDLHvuf3nJOZJGmylLkdNZ7GGn6
         1jm9QEt6fhN6g==
From:   Lee Jones <lee@kernel.org>
To:     william.gray@linaro.org, lee@kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230829134029.2402868-5-fabrice.gasnier@foss.st.com>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-5-fabrice.gasnier@foss.st.com>
Subject: Re: (subset) [PATCH 4/8] mfd: stm32-timers: add support for
 interrupts
Message-Id: <169529705167.3631705.15052366988953895917.b4-ty@kernel.org>
Date:   Thu, 21 Sep 2023 12:50:51 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 29 Aug 2023 15:40:25 +0200, Fabrice Gasnier wrote:
> There are two types of STM32 timers that may have:
> - a global interrupt line
> - 4 dedicated interrupt lines.
> Those interrupts are optional as defined in the dt-bindings. Enforce checks
> on either one, four or no interrupts are provided with their names.
> Optionally get them here, to be used by child devices.
> 
> [...]

Applied, thanks!

[4/8] mfd: stm32-timers: add support for interrupts
      commit: f747b627d395c4eb8a82849dcccf31bf46b21504

--
Lee Jones [李琼斯]

