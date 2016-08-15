Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41382 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbcHOPGn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 11:06:43 -0400
Subject: Re: [PATCH 1/2 v5] iio: magn: DT bindings for AK8974
To: Linus Walleij <linus.walleij@linaro.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1469454895-13659-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdaKaBVoRDqtoTtUPgLDZsHtMNUmdLhEktb2iaGoL=46xA@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6a9c9739-781d-506e-62f4-913251d2916d@kernel.org>
Date: Mon, 15 Aug 2016 16:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdaKaBVoRDqtoTtUPgLDZsHtMNUmdLhEktb2iaGoL=46xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/16 12:32, Linus Walleij wrote:
> On Mon, Jul 25, 2016 at 3:54 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>> This adds device tree bindings for the AK8974 magnetometer, similar
>> to those for the AK8975.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Samu Onkalo <samu.onkalo@intel.com>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v4->v5:
>> - No changes, just resend.
> 
> Jonathan can we merge this? People seem happy with it.
Hit the beginning of my holiday rather than anything else...

Applied to the togreg branch of iio.git - initially pushed out
as testing etc.

Jonathan
> 
> Dito for the actual driver patch 2/2.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

