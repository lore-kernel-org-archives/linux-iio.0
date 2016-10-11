Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54102 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753342AbcJKSqw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:46:52 -0400
Subject: Re: [PATCH v2] iio: accel: Add driver for the MiraMEMS DA280 3-axis
 14-bit digital accelerometer
To: Rob Herring <robh@kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <20161008181527.6646-1-hdegoede@redhat.com>
 <20161010214404.GA16737@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6c3e5afc-b0a1-11d4-83a7-e8883212700d@kernel.org>
Date: Tue, 11 Oct 2016 19:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <20161010214404.GA16737@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 22:44, Rob Herring wrote:
> On Sat, Oct 08, 2016 at 08:15:27PM +0200, Hans de Goede wrote:
>> Add an iio driver for the MiraMEMS DA280 3-axis 14-bit accelerometer, as
>> well as for the DA226 which is a fully compatible 2-axis version.
>>
>> Datasheets for the DA280 and DA226 can be found at the manufacturers site:
>> http://www.miramems.com/en/products.asp?list=1
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Drop le16_to_cpu, i2c_smbus_read_word_data() already does this
>> ---
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +
> 
> Acked-by: Rob Herring <robh@kernel.org>
Added.
> 
>>  drivers/iio/accel/Kconfig                          |  10 ++
>>  drivers/iio/accel/Makefile                         |   1 +
>>  drivers/iio/accel/da280.c                          | 183 +++++++++++++++++++++
>>  4 files changed, 196 insertions(+)
>>  create mode 100644 drivers/iio/accel/da280.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

