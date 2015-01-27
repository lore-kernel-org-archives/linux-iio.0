Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36397 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758625AbbA0Suv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 13:50:51 -0500
Message-ID: <54C7DDF4.80306@jic23.retrosnub.co.uk>
Date: Tue, 27 Jan 2015 18:50:28 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [iio:testing 20/20] drivers/iio/light/cm3232.c:354 cm3232_probe()
 warn: this array is probably non-NULL. 'id->name'
References: <20150126075258.GS6507@mwanda> <54C6A97B.4050601@kernel.org> <11AC7173B9064B2091A17EBB49F89149@GustyD430>
In-Reply-To: <11AC7173B9064B2091A17EBB49F89149@GustyD430>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/01/15 22:50, Kevin Tsai wrote:
> Hi Jonathan,
>
> Can you help to change as the following:
>
> indio_dev->info = &cm3232_info;
> indio_dev->name = id->name;
> indio_dev->modes = INDIO_DIRECT_MODE;
>
> Thanks.
>
Done.
> Kevin Tsai
> 01/26/15
>
> ----- Original Message ----- From: "Jonathan Cameron" <jic23@kernel.org>
> To: "Dan Carpenter" <dan.carpenter@oracle.com>; <kbuild@01.org>; "Kevin Tsai" <ktsai@capellamicro.com>
> Sent: Monday, January 26, 2015 12:54
> Subject: Re: [iio:testing 20/20] drivers/iio/light/cm3232.c:354 cm3232_probe() warn: this array is probably non-NULL. 'id->name'
>
>
>>
>> On 26/01/15 07:52, Dan Carpenter wrote:
>>> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
>>> head:   aa6799c6df77b76230bd150a668be920eba1ebcd
>>> commit: aa6799c6df77b76230bd150a668be920eba1ebcd [20/20] iio: Added Capella cm3232 ambient light sensor driver.
>>>
>>> drivers/iio/light/cm3232.c:354 cm3232_probe() warn: this array is probably non-NULL. 'id->name'
>> Hi Kevin,
>>
>> Are there any circumstances under which the probe gets called without id non null?
>>
>>>
>>> git remote add iio git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>>> git remote update iio
>>> git checkout aa6799c6df77b76230bd150a668be920eba1ebcd
>>> vim +354 drivers/iio/light/cm3232.c
>>>
>>> aa6799c6 Kevin Tsai 2015-01-15  338  struct cm3232_chip *chip;
>>> aa6799c6 Kevin Tsai 2015-01-15  339  struct iio_dev *indio_dev;
>>> aa6799c6 Kevin Tsai 2015-01-15  340  int ret;
>>> aa6799c6 Kevin Tsai 2015-01-15  341
>>> aa6799c6 Kevin Tsai 2015-01-15  342  indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>>> aa6799c6 Kevin Tsai 2015-01-15  343  if (!indio_dev)
>>> aa6799c6 Kevin Tsai 2015-01-15  344  return -ENOMEM;
>>> aa6799c6 Kevin Tsai 2015-01-15  345
>>> aa6799c6 Kevin Tsai 2015-01-15  346  chip = iio_priv(indio_dev);
>>> aa6799c6 Kevin Tsai 2015-01-15  347  i2c_set_clientdata(client, indio_dev);
>>> aa6799c6 Kevin Tsai 2015-01-15  348  chip->client = client;
>>> aa6799c6 Kevin Tsai 2015-01-15  349
>>> aa6799c6 Kevin Tsai 2015-01-15  350  indio_dev->dev.parent = &client->dev;
>>> aa6799c6 Kevin Tsai 2015-01-15  351  indio_dev->channels = cm3232_channels;
>>> aa6799c6 Kevin Tsai 2015-01-15  352  indio_dev->num_channels = ARRAY_SIZE(cm3232_channels);
>>> aa6799c6 Kevin Tsai 2015-01-15  353  indio_dev->info = &cm3232_info;
>>> aa6799c6 Kevin Tsai 2015-01-15 @354  if (id && id->name)
>>> aa6799c6 Kevin Tsai 2015-01-15  355  indio_dev->name = id->name;
>>> aa6799c6 Kevin Tsai 2015-01-15  356  else
>>> aa6799c6 Kevin Tsai 2015-01-15  357  indio_dev->name = (char *)dev_name(&client->dev);
>>> aa6799c6 Kevin Tsai 2015-01-15  358  indio_dev->modes = INDIO_DIRECT_MODE;
>>> aa6799c6 Kevin Tsai 2015-01-15  359
>>> aa6799c6 Kevin Tsai 2015-01-15  360  ret = cm3232_reg_init(chip);
>>> aa6799c6 Kevin Tsai 2015-01-15  361  if (ret) {
>>> aa6799c6 Kevin Tsai 2015-01-15  362  dev_err(&client->dev,
>>>
>>> ---
>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
>>>
>>
>

