Return-Path: <SRS0=yrAK=CZ=electromag.com.au=preid@kernel.org>
Subject: Re: [PATCH v4] iio : Add cm3218 smbus ara and acpi support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
  Wolfram Sang <wsa@the-dreams.de>,
  Jonathan Cameron <Jonathan.Cameron@huawei.com>,
  Marc CAPDEVILLE <m.capdeville@no-log.org>,
  Kevin Tsai <ktsai@capellamicro.com>,
  Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
  linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
  Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
  Benjamin Tissoires <benjamin.tissoires@redhat.com>,
  Jarkko Nikula <jarkko.nikula@linux.intel.com>
References: <20171027161426.m27e52jvnpgembsu@azrael>
 <20171102143550.00005a66@huawei.com>
 <20171102150407.bparxxskfo5pzvvs@ninjato> <20171119163551.5d52dec5@archlinux>
 <20171120105756.GC22431@lahna.fi.intel.com>
 <a8d2681c-b4c1-c1d9-0fca-dd72d2a82f1e@electromag.com.au>
 <20171125135711.174d2683@archlinux>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <577fbb51-2dcf-fe0f-f4c8-08e29699896d@electromag.com.au>
Date: Mon, 27 Nov 2017 10:55:39 +0800
MIME-Version: 1.0
In-Reply-To: <20171125135711.174d2683@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 25/11/2017 21:57, Jonathan Cameron wrote:
> On Tue, 21 Nov 2017 09:22:16 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> On 20/11/2017 18:57, Mika Westerberg wrote:
>>> +Jarkko
>>>
>>> On Sun, Nov 19, 2017 at 04:35:51PM +0000, Jonathan Cameron wrote:
>>>> On Thu, 2 Nov 2017 16:04:07 +0100
>>>> Wolfram Sang <wsa@the-dreams.de> wrote:
>>>>   
>>>>> On Thu, Nov 02, 2017 at 02:35:50PM +0000, Jonathan Cameron wrote:
>>>>>> On Fri, 27 Oct 2017 18:27:02 +0200
>>>>>> Marc CAPDEVILLE <m.capdeville@no-log.org> wrote:
>>>>>>       
>>>>>>> On asus T100, Capella cm3218 chip is implemented as ambiant light
>>>>>>> sensor. This chip expose an smbus ARA protocol device on standard
>>>>>>> address 0x0c. The chip is not functional before all alerts are
>>>>>>> acknowledged.
>>>>>>> On asus T100, this device is enumerated on ACPI bus and the
>>>>>>> description give tow I2C connection. The first is the connection to
>>>>>>> the ARA device and the second gives the real address of the device.
>>>>>>>
>>>>>>> So, on device probe,If the i2c address is the ARA address and the
>>>>>>> device is enumerated via acpi, we lookup for the real address in
>>>>>>> the ACPI resource list and change it in the client structure.
>>>>>>> if an interrupt resource is given, and only for cm3218 chip,
>>>>>>> we declare an smbus_alert device.
>>>>>>>
>>>>>>> Signed-off-by: Marc CAPDEVILLE <m.capdeville@no-log.org>
>>>>>>
>>>>>> Wolfram - this needs input from you on how to neatly handle
>>>>>> an ACPI registered ARA.
>>>>>
>>>>> ACPI is really not my field. Try asking the I2C ACPI maintainers or
>>>>> Benjamin Tissoires <benjamin.tissoires@redhat.com> who did work on SMBus
>>>>> interrupts recently.
>>>>>   
>>>> Hi Mika, Benjamin,
>>>>
>>>> So we've lost most of the context in this thread, but the basic question
>>>> is how to handle smbus ARA support with ACPI.
>>>>
>>>> https://patchwork.kernel.org/patch/10030309/
>>>>
>>>> Has the proposal made in this driver which is really not terribly nice
>>>> (as it registers the ARA device by messing with the address and registering
>>>> a second device).
>>>>
>>>> As I understood it the ARA device registration should be handled by the
>>>> i2c master, but there are very few examples.
>>>>
>>>> Phil pointed out that equivalent OF support recently got taken from him..
>>>> https://www.spinics.net/lists/devicetree/msg191947.html
>>>> https://www.spinics.net/lists/linux-i2c/msg31173.html
>>>>
>>>> Any thoughts on the right way to do this?
>>>
>>> There does not seem to be any way in ACPI to tell which "connection" is
>>> used to describe ARA so that part currently is something each driver
>>> needs to handle as they know the device the best. I don't think we have
>>> any means to handle it in generic way in I2C core except to provide some
>>> helpers that work on top of i2c_setup_smbus_alert() but understand ACPI
>>> resources. Say provide function like this:
>>>
>>>     int acpi_i2c_setup_smbus_alert(struct i2c_adapter *adapter, int index);
>>>
>>> Which then extracts automatically I2cSerialBus connection from "index"
>>> and calls i2c_setup_smbus_alert() accordingly.
>>>
>>> In the long run we could introduce _DSD property that can be used to
>>> name the connection in the same way DT does;
>>>
>>>       Name (_CRS, ResourceTemplate () {
>>>           I2cSerialBus () { ... } // ARA
>>>           I2cSerialBus () { ... } // normal device address
>>>       })
>>>
>>>       Name (_DSD, Package () {
>>>           ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>>           Package () {
>>>               Package () {"smbus_alert", 0} // Where 0 means the first I2cSerialBus
>>>               ...
>>>           }
>>>       })
>>>    
>>
>> I wonder if it's worth involving the smbus_alert driver in this case.
>> The cm3218 driver doesn't appear to be using the alert callback in strcut i2c_driver.
> 
> True - though it really should be..
> 
>> So the smbus_alert driver is not going to notifiy the cm3218 driver.
>> Are there more than one alert/ara capable devices on the bus?
> 
> I'm not keen on taking a work around for one board on the basis that
> it only has this one device on the bus - we will probably get a different
> one down the line where this isn't true - then we end up ripping up what
> has been done so far and starting again.
> 
> I don't mind having some ACPI matching code in the driver but it needs
> to use the ARA infrastructure to actually handle things...

I'd agree, I only suggested the approach as the driver didn't seem to be using the alert
callback. Without using that callback there seems little point using it IMO.

As you say the better approach is to have some generic ACPI code for the alert.

> 
> If we then get nice generic ACPI code via some other means in the future
> we can move the driver over to that.
> 
> Sometimes I wonder if some people just write ACPI tables with no though
> to generalization at all, or that the code running might be shared across
> different machines. (sometimes that assumption is valid, but not that
> often... oh well - usual case of if we all work together everyone wins
> but not worth one company trying to do things right...)
> 
>> Perhaps a workaround in this case is if that acpi entry is defined the cm3218 driver
>> handles that ara request directly to clear the interrupt.
>>
> 
> Jonathan
> 
> 


-- 
Regards
Phil Reid
