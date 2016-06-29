Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36598 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbcF2Rpr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2016 13:45:47 -0400
Subject: Re: [PATCH 03/10 v3] iio: pressure: bmp280: add reset GPIO line
 handling
To: Linus Walleij <linus.walleij@linaro.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org>
 <1467045020-2665-4-git-send-email-linus.walleij@linaro.org>
 <alpine.DEB.2.02.1606271851140.5271@pmeerw.net>
 <CACRpkdYCzAWQ0WrD9k1TZ0AYeX8D+cHyf9rr952nDcJJvWkoUg@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2e49a47a-3132-3d24-ea53-7cdd8eb48d90@kernel.org>
Date: Wed, 29 Jun 2016 18:45:40 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdYCzAWQ0WrD9k1TZ0AYeX8D+cHyf9rr952nDcJJvWkoUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/16 18:05, Linus Walleij wrote:
> On Mon, Jun 27, 2016 at 6:52 PM, Peter Meerwald-Stadler
> <pmeerw@pmeerw.net> wrote:
> 
>> On Mon, 27 Jun 2016, Linus Walleij wrote:
>>
>>> On the APQ8060 Dragonboard the reset line to the BMP058 pressure
>>
>> BMP085
> 
> Grr how do I switch these figures all the time...
> 
> I hope this can be fixed while applying in case this happens to
> be the only problem so far in the series.
It could, but there's enough here that I'll let you do it ;)
(+ you hinted that you've already been preparing another version)
> 
> Yours,
> Linus Walleij
> 

