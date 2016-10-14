Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:56449 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbcJNJBf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 05:01:35 -0400
Subject: Re: [bug report] iio: fetch and enable regulators unconditionally
To: Crt Mori <cmo@melexis.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20161012060719.GD12841@mwanda>
 <CAKv63uskg4u6p-rH=Vt7JqmAj-VpRSfJUcv1j0SWHdd=yafxFw@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Iio <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <27ebc18e-e99e-d4dc-1272-7b16d5231a79@metafoo.de>
Date: Fri, 14 Oct 2016 11:01:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAKv63uskg4u6p-rH=Vt7JqmAj-VpRSfJUcv1j0SWHdd=yafxFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2016 10:25 AM, Crt Mori wrote:
> Hello Dan,
> 
> On 12 October 2016 at 08:07, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> Hello Crt Mori,
>>
>> The patch 67516074884b: "iio: fetch and enable regulators
>> unconditionally" from Sep 5, 2016, leads to the following static
>> checker warning:
>>
>>         drivers/iio/pressure/ms5611_core.c:419 ms5611_init()
>>         error: 'st->vdd' dereferencing possible ERR_PTR()
>>
>> drivers/iio/pressure/ms5611_core.c
>>    388  static int ms5611_init(struct iio_dev *indio_dev)
>>    389  {
>>    390          int ret;
>>    391          struct ms5611_state *st = iio_priv(indio_dev);
>>    392
>>    393          /* Enable attached regulator if any. */
>>    394          st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
>>    395          if (!IS_ERR(st->vdd)) {
>>    396                  ret = regulator_enable(st->vdd);
>>    397                  if (ret) {
>>    398                          dev_err(indio_dev->dev.parent,
>>    399                                  "failed to enable Vdd supply: %d\n", ret);
>>    400                          return ret;
>>    401                  }
>>    402          } else {
>>    403                  ret = PTR_ERR(st->vdd);
>>    404                  if (ret != -ENODEV)
>>    405                          return ret;
>>
>> You probably want to update this chunk as well?  Otherwise static
>> checkers think we're dereferencing -ENODEV.
> 
> Can you explain a bit more why they would think of it like that and
> what would better proposal be like?
> 
> ret is a return value and it is st->vdd pointer is checked for error
> before we deduct error information out, so I do not see where
> dereferencing takes part?

The thing is, if PTR_ERR(st->vdd) is -ENODEV, we do not return an error and
just continue in the probe function. And then if one of the cleanup
functions is called st->vdd is passed to regulator_disable() which will
crash if it is passed -ENODEV instead of a valid pointer.

I think the ENODEV check should be dropped and the whole thing should be
turned into

if (IS_ERR(st->vdd))
	retrurn PTR_ERR(st->vdd))

ret = regulator_enable()
...

This is the behavior that we expect for normal supply regulators.

