Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33692 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcFUXQC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 19:16:02 -0400
Received: by mail-oi0-f48.google.com with SMTP id u201so7893512oie.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2016 16:16:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1466092715-20106-1-git-send-email-linus.walleij@linaro.org>
References: <1466092715-20106-1-git-send-email-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 22 Jun 2016 00:12:29 +0200
Message-ID: <CACRpkdZHN7G-GQHyfM_WLj-FjjADuTJjUyH5BO8-rzmvOD1hiQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: ak8975: add Vid regulator
To: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jun 16, 2016 at 5:58 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The AK8975 has two power sources: Vdd (analog voltage supply)
> and Vid (digital voltage supply). Optionally also obtain the Vid
> supply regulator and enable it.
>
> If an error occurs when enabling one of the regulators: bail out.
>
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Richard Leitner <dev@g0hl1n.net>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

After discussing with Mark Brown it was discovered that this regulator
code is just wrong, IS_ERR_OR_NULL() shall never be used with
regulators.

I extended the patch series to fix this, then add the Vid regulator,
then factor things around and add runtime PM.

Sending in a moment.

Yours,
Linus Walleij
