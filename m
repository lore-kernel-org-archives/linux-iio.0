Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36182 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbcHKLcI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Aug 2016 07:32:08 -0400
Received: by mail-oi0-f45.google.com with SMTP id f189so941191oig.3
        for <linux-iio@vger.kernel.org>; Thu, 11 Aug 2016 04:32:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469454895-13659-1-git-send-email-linus.walleij@linaro.org>
References: <1469454895-13659-1-git-send-email-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 11 Aug 2016 13:32:06 +0200
Message-ID: <CACRpkdaKaBVoRDqtoTtUPgLDZsHtMNUmdLhEktb2iaGoL=46xA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v5] iio: magn: DT bindings for AK8974
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 25, 2016 at 3:54 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This adds device tree bindings for the AK8974 magnetometer, similar
> to those for the AK8975.
>
> Cc: devicetree@vger.kernel.org
> Cc: Samu Onkalo <samu.onkalo@intel.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v4->v5:
> - No changes, just resend.

Jonathan can we merge this? People seem happy with it.

Dito for the actual driver patch 2/2.

Yours,
Linus Walleij
