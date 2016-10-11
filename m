Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54043 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbcJKSjW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:39:22 -0400
Subject: Re: [PATCH 2/4] iio: accel: Add driver for dmard10 3-axis
 Accelerometer
To: Rob Herring <robh@kernel.org>, Hans de Goede <hdegoede@redhat.com>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-3-hdegoede@redhat.com>
 <20161010214113.GA15075@rob-hp-laptop>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <03c7f2cb-a327-2b03-5eab-a873d3fa4a02@kernel.org>
Date: Tue, 11 Oct 2016 19:39:20 +0100
MIME-Version: 1.0
In-Reply-To: <20161010214113.GA15075@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 22:41, Rob Herring wrote:
> On Sat, Oct 08, 2016 at 02:34:24PM +0200, Hans de Goede wrote:
>> Add a driver for the Domintech ARD10 3-axis Accelerometer, based on the
>> android driver found here: https://github.com/domintech/dmard10
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -prefix all defines with DMARD10_ and uppercase them all
>> -Cleanup typography of some comments
>> -Use defines for offsets in databuffer
>> -Use i2c_smbus_write_byte_data() where applicable
>> -Reduce unnecessarily large buffer size in dmard10_shutdown()
>> -Use __le16 buffer in dmard10_read_raw()
>> Changes in v3:
>> -Express unit in m/s^2 instead of in "G"
>> ---
>>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
> 
> Acked-by: Rob Herring <robh@kernel.org>
Added.
> 
>>  drivers/iio/accel/Kconfig                          |  10 +
>>  drivers/iio/accel/Makefile                         |   1 +
>>  drivers/iio/accel/dmard10.c                        | 266 +++++++++++++++++++++
>>  4 files changed, 278 insertions(+)
>>  create mode 100644 drivers/iio/accel/dmard10.c

