Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53226 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcDQL1v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 07:27:51 -0400
Subject: Re: [PATCH 4/4 v5] iio: st_sensors: support open drain mode
To: Rob Herring <robh@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1460623521-8755-1-git-send-email-linus.walleij@linaro.org>
 <20160414170901.GA9172@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57137335.4060605@kernel.org>
Date: Sun, 17 Apr 2016 12:27:49 +0100
MIME-Version: 1.0
In-Reply-To: <20160414170901.GA9172@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 18:09, Rob Herring wrote:
> On Thu, Apr 14, 2016 at 10:45:21AM +0200, Linus Walleij wrote:
>> Some types of ST Sensors can be connected to the same IRQ line
>> as other peripherals using open drain. Add a device tree binding
>> and a sensor data property to flip the right bit in the interrupt
>> control register to enable open drain mode on the INT line.
>>
>> If the line is set to be open drain, also tag on IRQF_SHARED
>> to the IRQ flags when requesting the interrupt, as the whole
>> point of using open drain interrupt lines is to share them with
>> more than one peripheral (wire-or).
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Giuseppe Barba <giuseppe.barba@st.com>
>> Cc: Denis Ciocca <denis.ciocca@st.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> ChangeLog v4->v5:
>> - Rename DT bool property int-pin-open-drain to drive-mode-open-drain
>>   reusing the pin control subsystem binding.
>> ChangeLog v3->v4:
>> - Rename DT bool property st,int-pin-open-drain to int-pin-open-drain
>> - Rob Herring ACKed st,int-pin-open-drain but not including his ACK
>>   on this even though it's close
>> ChangeLog v2->v3:
>> - Rebase on top of the patches fixing the other issues (handling
>>   IRQ status check and channel reading bug).
>> ChangeLog v1->v2:
>> - Rebased to fit the new patch order.
>> ---
>>  Documentation/devicetree/bindings/iio/st-sensors.txt |  4 ++++
> 
> Acked-by: Rob Herring <rob@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
>>  drivers/iio/accel/st_accel_core.c                    |  8 ++++++++
>>  drivers/iio/common/st_sensors/st_sensors_core.c      | 20 ++++++++++++++++++++
>>  drivers/iio/common/st_sensors/st_sensors_trigger.c   | 13 +++++++++++++
>>  drivers/iio/pressure/st_pressure_core.c              |  8 ++++++++
>>  include/linux/iio/common/st_sensors.h                |  6 ++++++
>>  include/linux/platform_data/st_sensors_pdata.h       |  2 ++
>>  7 files changed, 61 insertions(+)

