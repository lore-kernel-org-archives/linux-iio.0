Return-Path: <jic23@kernel.org>
Message-ID: <50A14485.2060902@kernel.org>
Date: Mon, 12 Nov 2012 18:48:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Pavel Machek <pavel@denx.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "burman.yan@gmail.com" <burman.yan@gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
References: <5072F3B9.4050309@st.com> <5073260C.3010506@metafoo.de> <20121008195007.GA32042@elf.ucw.cz> <507338B5.60307@metafoo.de> <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com> <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com> <507D9EA3.4070009@metafoo.de> <5085128C.7020507@st.com> <50858B44.2080006@kernel.org> <5087E2A8.4070304@st.com> <508A7DA6.7050505@metafoo.de> <508E4492.8080000@st.com> <508E48D1.3000703@metafoo.de> <508E5978.5000907@st.com> <508E5AD5.1040907@metafoo.de> <50914366.4090000@st.com> <5091546D.9000601@metafoo.de> <CAEE_umoKvv9ciBfUSahDqsmcbHi9W=93o5YSpE-vxUduCmqWSQ@mail.gmail.com> <50982F71.3060606@kernel.org> <5098F065.1090009@st.com> <50A12D8C.6040207@st.com>
In-Reply-To: <50A12D8C.6040207@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/12/2012 05:10 PM, Denis CIOCCA wrote:
> Hi Jonathan,
> 
> can you please provide me one direction to modify the part in question 
> about the style of struct, in such a way I can do some modifications.
> 
Sorry, I haven't caught up with my emails for a few days!

Anyhow, quick reply below.
> Thanks,
> 
> Denis Ciocca
> 
> 
> 
> On 11/06/2012 12:11 PM, Denis Ciocca wrote:
>> Hi Jonathan,
>>
>> Thanks for your support!
>> I have applied your comments, only two point I would check better.
>>
>>
>>
>>>> +} st_accel_sensors[] = {
>>>> +     {
>>>> +             .wai = ST_ACCEL_1_WAI_EXP,
>>>> +             .ch = (struct iio_chan_spec *)st_accel_12bit_channels,
>>>> +             .odr = {
>>>> +                     .addr = ST_ACCEL_1_ODR_ADDR,
>>>> +                     .mask = ST_ACCEL_1_ODR_MASK,
>>>> +                     .num_bit = ST_ACCEL_1_ODR_N_BIT,
>>>> +                     .odr_avl = {
>>>    While sometimes c99 assignment helps with clarity - sometimes it
>>> just bloats the code.
>>>    Personally I'd do these as
>>>    .odr_avl = {{ST_ACCEL_ODR_AVL_1HZ, ST_ACCEL_1_ODR_AVL_1HZ_VAL},
>>>                {...}
>>> etc
>>>
>>> or for that matter take the view that the defines are largely
>>> pointless as they
>>> are only used here and
>>> just do
>>>       .odr_avl = {{1, 0x01},
>>>                   {10, 0x02},
>>> etc.
>>> Or maybe if it fits on the line
>>>     .odr_avl = {{ .hz = 1, .value = 0x01 } might be the clearest...
>>> Not sure.
>>>
>>
>> In my first version I have used about this compact approach but
>> Lars-Peter tell to me to use this style code:
>>  >I'd use
>>  > .odr_avl = {
>>  >        [0] = {
>>  >                ...
>>  >        },
>>  >        [1] = {
>>  >                ...
>>  >
>>  >Makes things a bit more readable in my opinion.
>>
>> Ok for me it is not a problem but you must tell me one definitive style
>> please. I think this style is more cleanly, though are necessary more rows.

The indexing gives no benefit - it's not relevant to the use of this
array as far as I can tell. Now we had index value pairs, then it would make
sense, but we don't.

My personal view is go for whatever gives the best combination of readability to
code compactness.  So here, where what we have is effectively key value pairs,
I'd just have them as an array.  Elsewhere, when you have general elements of
a structure then c99 style assignment is clearest and allows the structure
to sometimes be extended without needing to be careful about the ordering etc.

To a certain extent I don't care, I just thought for key value pairs there
was an awful lot of code here and it actually damaged readability rather
than enhancing it.

Hence have a think about it and go with whatever you think is clearest.

>
>
>>
>>
>>>> +/**
>>>> + * struct st_accel_platform_data - ST accel device platform data
>>>> + * @fullscale: Value of fullscale used for the sensor.
>>>> + * @sampling_frequency: Value of sampling frequency used for the
>>>> sensor.
>>>> + */
>>>> +
>>>> +struct st_accel_platform_data {
>>>> +     int fullscale;
>>>> +     int sampling_frequency;
>>>> +};
>>>
>>> What is the purpose of having these as platform data?
>>>
>>
>> For now the purpose is to set only the initial values for fullscale and
>> sampling_frequency but I think it's good thing include the mapping of
>> axis. You think it's necessary to remove this for now?
I'd not bother with it.  Just put a sensible default in the driver and
if anything else is wanted leave it up to userspace once the driver
is loaded.

Axis alignment is an interesting one.  So far we have it for just one
driver and that was to maintain feature parity with an existing driver
when we pulled it into the kernel.

It is often rather arbitary. The case where it matters is usually for
human input in which case it can be handled in the mapping code
(if using iio and the input bridge driver).
