Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50726 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbcEaNVV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2016 09:21:21 -0400
Subject: Re: [PATCH 3/7] iio: adc: ad7793: claim direct mode when writing
 frequency
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <96cee774e7a4269a73b0fcd476d8af575c10ac00.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZCVdWRP60GjHJNY8=0pOisY-FcVsVjErDD=sm8QeFgzHQ@mail.gmail.com>
 <8fee480e-f2cc-bb80-6328-0c2dcdb873e8@kernel.org>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <574D8FCB.8070806@metafoo.de>
Date: Tue, 31 May 2016 15:21:15 +0200
MIME-Version: 1.0
In-Reply-To: <8fee480e-f2cc-bb80-6328-0c2dcdb873e8@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2016 08:33 PM, Jonathan Cameron wrote:
> On 25/05/16 11:36, Daniel Baluta wrote:
>> On Tue, May 24, 2016 at 10:17 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>>> Driver was checking for direct mode and trying to lock it, but
>>> left a gap where mode could change before the desired operation.
>>> Use iio_device_claim_direct_mode() to guarantee device stays in
>>> direct mode.
>>>
>>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>>
>> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
> Again, this one is not quite so trivial so I'll wait for Lars to take a look
> even though I'm happy with it.

Same as patch too. Looks good otherwise.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
