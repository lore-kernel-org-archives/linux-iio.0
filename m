Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35188 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbcJNLTJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 07:19:09 -0400
Received: by mail-lf0-f49.google.com with SMTP id l131so149017976lfl.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Oct 2016 04:18:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <27ebc18e-e99e-d4dc-1272-7b16d5231a79@metafoo.de>
References: <20161012060719.GD12841@mwanda> <CAKv63uskg4u6p-rH=Vt7JqmAj-VpRSfJUcv1j0SWHdd=yafxFw@mail.gmail.com>
 <27ebc18e-e99e-d4dc-1272-7b16d5231a79@metafoo.de>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 14 Oct 2016 13:17:33 +0200
Message-ID: <CAKv63usG_9UCH-ystaQtLqsVXRvT3pOvBbJ1nDY_HggTETyXdw@mail.gmail.com>
Subject: Re: [bug report] iio: fetch and enable regulators unconditionally
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Iio <linux-iio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14 October 2016 at 11:01, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 10/13/2016 10:25 AM, Crt Mori wrote:
>> Hello Dan,
>>
>> On 12 October 2016 at 08:07, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>>> Hello Crt Mori,
>>>
>>> The patch 67516074884b: "iio: fetch and enable regulators
>>> unconditionally" from Sep 5, 2016, leads to the following static
>>> checker warning:
>>>
>>>         drivers/iio/pressure/ms5611_core.c:419 ms5611_init()
>>>         error: 'st->vdd' dereferencing possible ERR_PTR()
>>>
>>> drivers/iio/pressure/ms5611_core.c
>>>    388  static int ms5611_init(struct iio_dev *indio_dev)
>>>    389  {
>>>    390          int ret;
>>>    391          struct ms5611_state *st = iio_priv(indio_dev);
>>>    392
>>>    393          /* Enable attached regulator if any. */
>>>    394          st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
>>>    395          if (!IS_ERR(st->vdd)) {
>>>    396                  ret = regulator_enable(st->vdd);
>>>    397                  if (ret) {
>>>    398                          dev_err(indio_dev->dev.parent,
>>>    399                                  "failed to enable Vdd supply: %d\n", ret);
>>>    400                          return ret;
>>>    401                  }
>>>    402          } else {
>>>    403                  ret = PTR_ERR(st->vdd);
>>>    404                  if (ret != -ENODEV)
>>>    405                          return ret;
>>>
>>> You probably want to update this chunk as well?  Otherwise static
>>> checkers think we're dereferencing -ENODEV.
>>
>> Can you explain a bit more why they would think of it like that and
>> what would better proposal be like?
>>
>> ret is a return value and it is st->vdd pointer is checked for error
>> before we deduct error information out, so I do not see where
>> dereferencing takes part?
>
> The thing is, if PTR_ERR(st->vdd) is -ENODEV, we do not return an error and
> just continue in the probe function. And then if one of the cleanup
> functions is called st->vdd is passed to regulator_disable() which will
> crash if it is passed -ENODEV instead of a valid pointer.
>
> I think the ENODEV check should be dropped and the whole thing should be
> turned into
>
> if (IS_ERR(st->vdd))
>         retrurn PTR_ERR(st->vdd))
>
> ret = regulator_enable()
> ...
>
> This is the behavior that we expect for normal supply regulators.
This would then make us completely dependent on this behaviour:
    If the device tree or board file does not define suitable regulators for
    the component, it will be substituted by a dummy regulator, or, if
    regulators are disabled altogether, by stubs.
which I read as that it will not return ENODEV anyway, so we are safe
to assume something else went wrong whenever error is returned?
I have added Linus Wallerij to the discussion as might also be valid
for his solution?
