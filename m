Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F84436164D;
	Mon, 27 Jul 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134420; cv=none; b=QQl4VqJNoSpwI3icMciyT3kLGZIyqo1RIUj9KsT7mS2Tp7MX0fOQNXEM9qlm1ccBTAHrRkhHbn+kYsZEuoIY3pD7TeEr8skhOZZhgiy59Zx7z/Y6EIBEPYck7u/Ll6N2NLr3PaZkdekU4ehX56aEbXE+ir1O2K3ygMmdcQQYuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134420; c=relaxed/simple;
	bh=ihhnH7zTTOD25SazKPc2tjiiikmGXfXOgy837UKcjQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5lf4APv4WORJPXhFofyMBYM3Z0iKHO791ksZNlmyQmOKk9R1lHNqwcd8WR6wqSBgLyhG2tMpdtrPtOw7CRAw7LU4PtJuhiYbCKXsR1XZtl9fg9ipxh+ereIoDiGPuR3qA9keiRNHGtLMTG7h3fJVWs8pkarYEvGCEsHdN17E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600BE1F000E9;
	Mon, 27 Jul 2026 06:40:13 +0000 (UTC)
Message-ID: <cf85a0be-ddfb-4309-a605-3cf34121b29f@tuxon.dev>
Date: Mon, 27 Jul 2026 09:40:11 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] nvmem: microchip-otpc: add tag-based packet
 lookup
To: Varshini.Rajendran@microchip.com
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 jorge.marques@analog.com, mazziesaccount@gmail.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-7-varshini.rajendran@microchip.com>
 <3998b196-6417-49b0-b8d3-a95a5b415916@tuxon.dev>
 <5e940d60-3137-49d5-8a62-25c746c58d7e@microchip.com>
 <87697527-0aff-4647-ae11-0eb51db9b134@tuxon.dev>
 <5f84fd39-e8cd-488e-95f5-6fd39c3c6acb@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <5f84fd39-e8cd-488e-95f5-6fd39c3c6acb@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Varshini,

On 7/27/26 09:24, Varshini.Rajendran@microchip.com wrote:
> Hi Claudiu,
> 
> On 25/07/26 7:57 pm, Claudiu Beznea wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> the content is safe
>>
>> Hi, Varshini,
>>
>> On 7/22/26 08:50, Varshini.Rajendran@microchip.com wrote:
>>> Hi Claudiu,
>>>
>>> Thanks for taking the time to review.
>>>
>>> On 22/07/26 12:44 am, Claudiu Beznea wrote:
>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>>>> the content is safe
>>>>
>>>> Hi, Varshini,
>>>>
>>>> On 6/30/26 12:35, Varshini Rajendran wrote:
>>>>> Add support for accessing OTP packets by their 4-byte ASCII tag while
>>>>> preserving backward compatibility with the existing ID-based lookup.
>>>>>
>>>>> The OTP memory layout can vary across devices and may change over time,
>>>>> making the packet ID approach unreliable when the memory map is not
>>>>> known in advance. The packet tag provides a reliable way to identify
>>>>> and access packets without prior knowledge of the OTP memory layout.
>>>>>
>>>>> Two offset encoding are now supported:
>>>>>      1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>>>>>         Used in DT as: reg = <OTP_PKT(1) 76>;
>>>>>      2. TAG-based: offset = 4-byte ASCII packet tag
>>>>>         Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
>>>>>
>>>>
>>>> I think this:
>>>>
>>>>> The driver resolves offsets matching valid legacy selectors (multiples
>>>>> of 4 within the packet count) through ID lookup, falling back to tag
>>>>> lookup for other values. This ensures existing device trees continue
>>>>> to work while enabling new tag-based access.
>>>>
>>>> should fall in a different patch?
>>>
>>> You mean moving the "invoking the new tag-based method with the legacy
>>> method as a fallback" part alone? Only add the functions in this patch
>>> and invoking them in the next one - Did I get it right?
>>
>> Ah, apologies for confusion, I referred to the wrong section. I wanted
>> to refer
>> to this section:
>>
>>>>> The driver also validates OTP memory accessibility and emulation mode
>>>>> status. When the boot packet is not configured, emulation mode allows
>>>>> access to the other packets. When both are not available an
>>>>> informational message is logged.
>>
>> That is handled through this code:
>>
>> +
>> +       tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
>> +       emul_enable = tmp & MCHP_OTPC_MR_EMUL;
>> +       if (emul_enable)
>> +               dev_info(otpc->dev, "Emulation mode enabled\n");
>> +
>>          ret = mchp_otpc_init_packets_list(otpc, &size);
>>          if (ret)
>>                  return ret;
>>
>> +       if (!size) {
>> +               dev_warn(otpc->dev, "Cannot access OTP memory\n");
>> +               if (!emul_enable)
>> +                       dev_info(otpc->dev, "Boot packet not programmed
>> and emulation mode disabled\n");
>> +       }
>> +
>>
>> This I think should go in a different patch.
>>
>>>
>>>>
>>>>>
>>>>> During probe, packet meta data including the tag is read and cached.
>>>>> The driver also validates OTP memory accessibility and emulation mode
>>>>> status. When the boot packet is not configured, emulation mode allows
>>>>> access to the other packets. When both are not available an
>>>>> informational message is logged.
>>>>>
>>>>> The stride of the nvmem memory is set to 1 in order to support tag
>>>>> based
>>>>> offsets, comment in the header file is updated accordingly.
>>>>>
>>>>> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
>>>>> ---
>>>>>     drivers/nvmem/microchip-otpc.c                | 143 +++++++++++++
>>>>> +++--
>>>>>     .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
>>>>>     2 files changed, 136 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-
>>>>> otpc.c
>>>>> index df979e8549fd..bf8589048e17 100644
>>>>> --- a/drivers/nvmem/microchip-otpc.c
>>>>> +++ b/drivers/nvmem/microchip-otpc.c
>>>>> @@ -18,16 +18,20 @@
>>>>>     #define MCHP_OTPC_CR_READ           BIT(6)
>>>>>     #define MCHP_OTPC_MR                        (0x4)
>>>>>     #define MCHP_OTPC_MR_ADDR           GENMASK(31, 16)
>>>>> +#define MCHP_OTPC_MR_EMUL            BIT(7)
>>>>>     #define MCHP_OTPC_AR                        (0x8)
>>>>>     #define MCHP_OTPC_SR                        (0xc)
>>>>>     #define MCHP_OTPC_SR_READ           BIT(6)
>>>>>     #define MCHP_OTPC_HR                        (0x20)
>>>>>     #define MCHP_OTPC_HR_SIZE           GENMASK(15, 8)
>>>>> +#define MCHP_OTPC_HR_PACKET_TYPE     GENMASK(2, 0)
>>>>
>>>> Nit: in SAMA7D65 manual this is simply packet. Maybe rename it:
>>>> MCHP_OTPC_HR_PACKET to match the manual.
>>>>
>>>>>     #define MCHP_OTPC_DR                        (0x24)
>>>>>
>>>>>     #define MCHP_OTPC_NAME                      "mchp-otpc"
>>>>>     #define MCHP_OTPC_SIZE                      (11 * 1024)
>>>>>
>>>>> +#define PACKET_TYPE_REGULAR          1
>>>>
>>>> I would move this close to MCHP_OTPC_HR_PACKET_TYPE and name it
>>>> something like:
>>>> MCHP_OTPC_HR_PACKET_REGULAR to match the datasheet.
>>>>
>>>>> +
>>>>>     /**
>>>>>      * struct mchp_otpc - OTPC private data structure
>>>>>      * @base: base address
>>>>> @@ -47,11 +51,15 @@ struct mchp_otpc {
>>>>>      * @list: list head
>>>>>      * @id: packet ID
>>>>>      * @offset: packet offset (in words) in OTP memory
>>>>> + * @type: type of the packet
>>>>> + * @tag: 4-byte ASCII tag of the packet
>>>>>      */
>>>>>     struct mchp_otpc_packet {
>>>>>         struct list_head list;
>>>>>         u32 id;
>>>>>         u32 offset;
>>>>> +     u32 type;
>>>>
>>>> This can be dropped for now since it's used only in the initialization
>>>> path.
>>>>
>>>>> +     u32 tag;
>>>>>     };
>>>>>
>>>>>     static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct
>>>>> mchp_otpc *otpc,
>>>>> @@ -70,6 +78,56 @@ static struct mchp_otpc_packet
>>>>> *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
>>>>>         return NULL;
>>>>>     }
>>>>>
>>>>> +/**
>>>>> + * mchp_otpc_tag_to_packet() - find packet by tag
>>>>> + * @otpc: OTPC private data
>>>>> + * @tag: 4-byte ASCII tag to search for
>>>>> + *
>>>>> + * Return: pointer to packet if found, NULL otherwise
>>>>> + */
>>>>
>>>> I'm not sure we need this description since the function is simple
>>>> enough. I
>>>> would drop it.
>>>>
>>>>> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct
>>>>> mchp_otpc *otpc,
>>>>> +                                                     u32 tag)
>>>>> +{
>>>>> +     struct mchp_otpc_packet *packet;
>>>>> +
>>>>> +     list_for_each_entry(packet, &otpc->packets, list) {
>>>>> +             if (packet->tag == tag)
>>>>> +                     return packet;
>>>>> +     }
>>>>> +
>>>>> +     return NULL;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * mchp_otpc_resolve_packet() - resolve offset to packet
>>>>> + * @otpc: OTPC private data
>>>>> + * @off: NVMEM offset (legacy ID-based or TAG-based)
>>>>> + *
>>>>> + * Legacy offsets (multiples of 4 within valid ID range) are resolved
>>>>> + * through ID lookup. Other offsets are treated as 4-byte ASCII tags.
>>>>> + *
>>>>> + * Return: pointer to packet if found, NULL otherwise
>>>>> + */
>>>>
>>>> Same here.
>>>>
>>>>> +static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct
>>>>> mchp_otpc *otpc,
>>>>> +                                                      u32 off)
>>>>> +{
>>>>> +     /*
>>>>> +      * Legacy id based packet access: offset = id * 4
>>>>> +      * Inside the driver we use continuous unsigned integer numbers
>>>>> +      * for packet id, thus divide off by 4 before passing it to
>>>>> +      * mchp_otpc_id_to_packet().
>>>>> +      */
>>>>> +     u32 id = off / 4;
>>>>> +
>>>>> +     if (!(off % 4) && id < otpc->npackets)
>>>>
>>>> The tag can be anything, no? Can't the tag satisfy this condition and
>>>> the
>>>> execution to wrongly use mchp_otpc_id_to_packet() ?
>>>
>>> The tag is a FourCC code. So the minimum value would be 0x20202020 which
>>> way too big than the number of packets the OTP could hold. So this
>>> condition pretty much never fails. If you want me to add this
>>> "0x20202020" value as an additional check I can do that.
>>
>> Please mention FourCC in patch description.
> 
> Yes. I will do this.
> 
>>
>> Also, I think one would manage to access a packet with a tag that is not in
>> FourCC format (tag >= 0x20202020). E.g. if the memory footprint is:
>>
>>    Header 0
>> -----------
>>    Payload 0:
>>    tag0 = 0x20202020
>> -----------
>>    Header 1
>> -----------
>>    Payload 1:
>>    tag1 = 0x00002020
>> ------------
>>    Header 2
>> ------------
>>    Payload 2:
>>    tag2 = 0x00000004
>> -----------
>>    Header 3
>> -----------
>>    Payload 3:
>>    tag3 = 0x00002020
>> -----------
>>    Header 4
>> -----------
>>    Payload 4:
>>    tag3 = 0x00002020
>>
>>
>> Since the initialization function mchp_otpc_read_packet_tag() don't
>> validate the
>> FourCC format with the minimal FourCC value, it will create a list with 5
>> packets as follows:
>>
>> packet0:
>> - id = 0
>> - tag = 0x20202020
>>
>> packet1:
>> - id = 0
>> - tag = 0x00002020
>>
>> packet2:
>> - id = 2
>> - tag = 0x00000004
>>
>> packet3:
>> - id = 3
>> - tag = 0x00002020
>>
>> packet4:
>> - id = 4
>> - tag = 0x00002020
>>
>> Thus, reaching mchp_otpc_read() with off=0x00002020 will allow the user
>> to get
>> packet1 using tag method (even though the user flashed multiple packets
>> with the
>> same tag; I'm not sure if we should validate this).
>>
>> At the same time if off=0x00000004 (corresponding to packet2) the code will
>> return the payload of packet1 as it will resolve the packet using
>> mchp_otpc_id_to_packet().
> 
> 
> Yes. That is correct. But since the tag will technically be a FourCC
> code, this problem will not arise. For caution, I can validate the tag
> if it is a FourCC code, before creating the table of contents for the
> packets.

That would be good. Please add this validation.

Thank you,
Claudiu
