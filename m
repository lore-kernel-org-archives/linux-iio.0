Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54101 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbcJKSqw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:46:52 -0400
Subject: Re: [PATCH 3/4] iio: accel: Add driver for the MiraMEMS DA311 3-axis
 12-bit digital accelerometer
To: Rob Herring <robh@kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-4-hdegoede@redhat.com>
 <20161010214139.GA15600@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d675ccd1-b627-74ab-39c3-5dc45326e8e9@kernel.org>
Date: Tue, 11 Oct 2016 19:39:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161010214139.GA15600@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 22:41, Rob Herring wrote:
> On Sat, Oct 08, 2016 at 02:34:25PM +0200, Hans de Goede wrote:
>> This driver is based on the DA311 Android driver which can be found here:
>> https://git.matricom.net/Firmware/kernel_amlogic_meson-common/tree/1e70113a5befd07debb68f537156def84c5be57a/drivers/amlogic/input/sensor
>> the mir3da_* files are the DA311 driver.
>>
>> Unfortunately there is no datasheet.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Add proper prefix to patch Subject
>> -Use i2c_smbus_read_word_data() instead of i2c_smbus_read_i2c_block_data()
>> Changes in v3:
>> -Express unit in m/s^2 instead of in "G"
>> -Drop le16_to_cpu, i2c_smbus_read_word_data() already does this
>> ---
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
> 
> Acked-by: Rob Herring <robh@kernel.org>
added.
> 
>>  drivers/iio/accel/Kconfig                          |  10 +
>>  drivers/iio/accel/Makefile                         |   1 +
>>  drivers/iio/accel/da311.c                          | 305 +++++++++++++++++++++
>>  4 files changed, 317 insertions(+)
>>  create mode 100644 drivers/iio/accel/da311.c

