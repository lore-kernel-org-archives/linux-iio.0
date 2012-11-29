Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-237.synserver.de ([212.40.185.237]:1065 "EHLO
	smtp-out-237.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803Ab2K2KSH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Nov 2012 05:18:07 -0500
Message-ID: <50B7366A.9040800@metafoo.de>
Date: Thu, 29 Nov 2012 11:18:18 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Corentin Chary <corentin.chary@gmail.com>
CC: =?UTF-8?B?TWFydGluIExpxaFrYQ==?= <marxin.liska@gmail.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, linux-iio@vger.kernel.org,
	"Zhang, Rui" <rui.zhang@intel.com>, joeyli <jlee@suse.com>,
	Len Brown <len.brown@intel.com>, pavel@denx.de,
	Jon Brenner <jbrenner@taosinc.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] ACPI ALS driver for iio introduced.
References: <CAHR064j_7Y3wYXVXmC4TqZHxkqa0Z2HK84-OaDTiC7oesB_TrQ@mail.gmail.com> <1354157205-2956-1-git-send-email-marxin.liska@gmail.com> <1354157205-2956-2-git-send-email-marxin.liska@gmail.com> <CAHR064gj3CUUZyuGiw6WhLjGQrhq-eAOKr-=+UmpW2Ry3mce8g@mail.gmail.com>
In-Reply-To: <CAHR064gj3CUUZyuGiw6WhLjGQrhq-eAOKr-=+UmpW2Ry3mce8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/29/2012 09:02 AM, Corentin Chary wrote:
> On Thu, Nov 29, 2012 at 2:46 AM,  <marxin.liska@gmail.com> wrote:
>> From: marxin <marxin.liska@gmail.com>
>>
>> ---
>>  drivers/iio/industrialio-buffer.c    |    4 +-
>>  drivers/staging/iio/light/Kconfig    |    6 +
>>  drivers/staging/iio/light/Makefile   |    1 +
>>  drivers/staging/iio/light/acpi-als.c |  486 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 495 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/staging/iio/light/acpi-als.c
>>
>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
>> index aaadd32..b8b377c 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -119,8 +119,8 @@ static ssize_t iio_scan_el_show(struct device *dev,
>>         int ret;
>>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>
>> -       ret = test_bit(to_iio_dev_attr(attr)->address,
>> -                      indio_dev->buffer->scan_mask);
>> +       ret = !!(test_bit(to_iio_dev_attr(attr)->address,
>> +                      indio_dev->buffer->scan_mask));
> 
> It's strange that you have to do that.
> Can you give use the exact values that make test_bit return something
> else that 1 or 0 ?
> Maybe there is a bug to fix in test_bit here.

Even if this was a bug in IIO this should be in a separate patch.

> 
>>
>>         return sprintf(buf, "%d\n", ret);
>>  }
[...]
