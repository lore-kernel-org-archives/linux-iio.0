Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2146EC9A;
	Tue, 21 Jul 2026 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661268; cv=none; b=tNAIh3QdDd8idC4EzHanCIkgYbr647sWD407Lm9ZML2wry6JuOWRMbp8CNCH9amQavgQtXPoXyEp4yJTzeT2D0FLwS06M4oUoRcl4W9XGxwnjOgcYHx650G5GNQ/JjnnM+PCjZm+9TkCH3FdM43XunYhK77xxZbQUCGfNbnHp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661268; c=relaxed/simple;
	bh=DRpBKScvMn7khGTK7HeYLZTNNTOzXh3UM5du8CkgUZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D87UqVbP9eRewYxMkW3DuBk+O45lr2oareSrVIXlERWKBA7ke/jjkY7I5DZhpBR4PZNqStp9bASZhPFsTnVA0TtDbX64sbiVyrFwg15qLzVxPOIrCNADt3GXxAVcM2JpYAigHLov1qhblvCshuVArqQC/fCXQxXmhyPzM1BuWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7240D1F00A3D;
	Tue, 21 Jul 2026 19:14:21 +0000 (UTC)
Message-ID: <3998b196-6417-49b0-b8d3-a95a5b415916@tuxon.dev>
Date: Tue, 21 Jul 2026 22:14:19 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] nvmem: microchip-otpc: add tag-based packet
 lookup
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 jorge.marques@analog.com, mazziesaccount@gmail.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
 <20260630093603.38663-7-varshini.rajendran@microchip.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260630093603.38663-7-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 6/30/26 12:35, Varshini Rajendran wrote:
> Add support for accessing OTP packets by their 4-byte ASCII tag while
> preserving backward compatibility with the existing ID-based lookup.
> 
> The OTP memory layout can vary across devices and may change over time,
> making the packet ID approach unreliable when the memory map is not
> known in advance. The packet tag provides a reliable way to identify
> and access packets without prior knowledge of the OTP memory layout.
> 
> Two offset encoding are now supported:
>    1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>       Used in DT as: reg = <OTP_PKT(1) 76>;
>    2. TAG-based: offset = 4-byte ASCII packet tag
>       Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> 

I think this:

> The driver resolves offsets matching valid legacy selectors (multiples
> of 4 within the packet count) through ID lookup, falling back to tag
> lookup for other values. This ensures existing device trees continue
> to work while enabling new tag-based access.

should fall in a different patch?

> 
> During probe, packet meta data including the tag is read and cached.
> The driver also validates OTP memory accessibility and emulation mode
> status. When the boot packet is not configured, emulation mode allows
> access to the other packets. When both are not available an
> informational message is logged.
> 
> The stride of the nvmem memory is set to 1 in order to support tag based
> offsets, comment in the header file is updated accordingly.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>   drivers/nvmem/microchip-otpc.c                | 143 ++++++++++++++++--
>   .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
>   2 files changed, 136 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index df979e8549fd..bf8589048e17 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -18,16 +18,20 @@
>   #define MCHP_OTPC_CR_READ		BIT(6)
>   #define MCHP_OTPC_MR			(0x4)
>   #define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
> +#define MCHP_OTPC_MR_EMUL		BIT(7)
>   #define MCHP_OTPC_AR			(0x8)
>   #define MCHP_OTPC_SR			(0xc)
>   #define MCHP_OTPC_SR_READ		BIT(6)
>   #define MCHP_OTPC_HR			(0x20)
>   #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
> +#define MCHP_OTPC_HR_PACKET_TYPE	GENMASK(2, 0)

Nit: in SAMA7D65 manual this is simply packet. Maybe rename it:
MCHP_OTPC_HR_PACKET to match the manual.

>   #define MCHP_OTPC_DR			(0x24)
>   
>   #define MCHP_OTPC_NAME			"mchp-otpc"
>   #define MCHP_OTPC_SIZE			(11 * 1024)
>   
> +#define PACKET_TYPE_REGULAR		1

I would move this close to MCHP_OTPC_HR_PACKET_TYPE and name it something like:
MCHP_OTPC_HR_PACKET_REGULAR to match the datasheet.

> +
>   /**
>    * struct mchp_otpc - OTPC private data structure
>    * @base: base address
> @@ -47,11 +51,15 @@ struct mchp_otpc {
>    * @list: list head
>    * @id: packet ID
>    * @offset: packet offset (in words) in OTP memory
> + * @type: type of the packet
> + * @tag: 4-byte ASCII tag of the packet
>    */
>   struct mchp_otpc_packet {
>   	struct list_head list;
>   	u32 id;
>   	u32 offset;
> +	u32 type;

This can be dropped for now since it's used only in the initialization path.

> +	u32 tag;
>   };
>   
>   static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
> @@ -70,6 +78,56 @@ static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
>   	return NULL;
>   }
>   
> +/**
> + * mchp_otpc_tag_to_packet() - find packet by tag
> + * @otpc: OTPC private data
> + * @tag: 4-byte ASCII tag to search for
> + *
> + * Return: pointer to packet if found, NULL otherwise
> + */

I'm not sure we need this description since the function is simple enough. I 
would drop it.

> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc,
> +							u32 tag)
> +{
> +	struct mchp_otpc_packet *packet;
> +
> +	list_for_each_entry(packet, &otpc->packets, list) {
> +		if (packet->tag == tag)
> +			return packet;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * mchp_otpc_resolve_packet() - resolve offset to packet
> + * @otpc: OTPC private data
> + * @off: NVMEM offset (legacy ID-based or TAG-based)
> + *
> + * Legacy offsets (multiples of 4 within valid ID range) are resolved
> + * through ID lookup. Other offsets are treated as 4-byte ASCII tags.
> + *
> + * Return: pointer to packet if found, NULL otherwise
> + */

Same here.

> +static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc,
> +							 u32 off)
> +{
> +	/*
> +	 * Legacy id based packet access: offset = id * 4
> +	 * Inside the driver we use continuous unsigned integer numbers
> +	 * for packet id, thus divide off by 4 before passing it to
> +	 * mchp_otpc_id_to_packet().
> +	 */
> +	u32 id = off / 4;
> +
> +	if (!(off % 4) && id < otpc->npackets)

The tag can be anything, no? Can't the tag satisfy this condition and the 
execution to wrongly use mchp_otpc_id_to_packet() ?

> +		return mchp_otpc_id_to_packet(otpc, id);
> +
> +	/*
> +	 * TAG-based packet access: offset is a 4-byte ASCII tag
> +	 */
> +	return mchp_otpc_tag_to_packet(otpc, off);
> +}
> +
>   static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>   				  unsigned int offset)
>   {
> @@ -140,8 +198,29 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>    * offset returned by hardware.
>    *
>    * For this, the read function will return the first requested bytes in the
> - * packet. The user will have to be aware of the memory footprint before doing
> - * the read request.
> + * packet.
> + *
> + * Two offset encoding are supported:
> + *
> + * 1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
> + *    Used in DT as: reg = <OTP_PKT(1) 76>;
> + * 2. TAG-based: offset = 4-byte ASCII packet tag
> + *    Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> + *
> + * To use the legacy ID based packet lookup the user will have to be aware of
> + * the memory footprint before doing the read request.
> + *
> + * But by using the TAG based packet lookup, the user won't have to be aware
> + * of the memory footprint before doing the read request since this driver has
> + * it abstracted and taken care of.
> + *
> + * Practically, there is no way of knowing the mapping of the OTP memory table
> + * in advance for every device. But by using the packet tag - the identifier
> + * ASCII value, the packets can be recognized without being aware of the
> + * flashed OTP memory map table and the payload can be acquired reliably.
> + *
> + * While the legacy ID based lookup is still supported, TAG based approach is
> + * recommended.
>    */
>   static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>   			  size_t bytes)
> @@ -154,12 +233,11 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>   	int ret, payload_size;
>   
>   	/*
> -	 * We reach this point with off being multiple of stride = 4 to
> -	 * be able to cross the subsystem. Inside the driver we use continuous
> -	 * unsigned integer numbers for packet id, thus divide off by 4
> -	 * before passing it to mchp_otpc_id_to_packet().
> +	 * From this point the offset has to be translated into the actual
> +	 * packet. For this we traverse the table of contents stored in a list
> +	 * "packet" based on the access type - packet id or tag.
>   	 */
> -	packet = mchp_otpc_id_to_packet(otpc, off / 4);
> +	packet = mchp_otpc_resolve_packet(otpc, off);
>   	if (!packet)
>   		return -EINVAL;
>   	offset = packet->offset;
> @@ -190,6 +268,29 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>   	return 0;
>   }
>   
> +/**
> + * mchp_otpc_read_packet_tag() - read tag from packet payload
> + * @otpc: OTPC private data
> + * @offset: packet offset in OTP memory
> + * @val: pointer to store the tag value
> + *
> + * Return: 0 on success, negative errno on failure
> + */

Same here regarding the description.

> +static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset,
> +				     unsigned int *val)

I think would be better to rename val to tag.

> +{
> +	int ret;
> +
> +	ret = mchp_otpc_prepare_read(otpc, offset);
> +	if (ret)
> +		return ret;
> +
> +	writel_relaxed(0, otpc->base + MCHP_OTPC_AR);
> +	*val = readl_relaxed(otpc->base + MCHP_OTPC_DR);
> +
> +	return 0;
> +}
> +
>   static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>   {
>   	struct mchp_otpc_packet *packet;
> @@ -215,6 +316,17 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>   
>   		packet->id = id++;
>   		packet->offset = word_pos;
> +		packet->type = FIELD_GET(MCHP_OTPC_HR_PACKET_TYPE, word);
> +
> +		if (packet->type == PACKET_TYPE_REGULAR) {
> +			ret = mchp_otpc_read_packet_tag(otpc, packet->offset,
> +							&packet->tag);
> +			if (ret)
> +				return ret;
> +		} else {
> +			packet->tag = 0;
> +		}
> +
>   		INIT_LIST_HEAD(&packet->list);
>   		list_add_tail(&packet->list, &otpc->packets);
>   
> @@ -236,7 +348,7 @@ static struct nvmem_config mchp_nvmem_config = {
>   	.type = NVMEM_TYPE_OTP,
>   	.read_only = true,
>   	.word_size = 4,
> -	.stride = 4,
> +	.stride = 1,
>   	.reg_read = mchp_otpc_read,
>   };
>   
> @@ -244,7 +356,8 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>   {
>   	struct nvmem_device *nvmem;
>   	struct mchp_otpc *otpc;
> -	u32 size;
> +	bool emul_enable;
> +	u32 size, tmp;
>   	int ret;
>   
>   	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
> @@ -256,10 +369,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
>   		return PTR_ERR(otpc->base);
>   
>   	otpc->dev = &pdev->dev;
> +
> +	tmp = readl_relaxed(otpc->base + MCHP_OTPC_MR);
> +	emul_enable = tmp & MCHP_OTPC_MR_EMUL;
> +	if (emul_enable)
> +		dev_info(otpc->dev, "Emulation mode enabled\n");
> +

Looks to me that this section ^

>   	ret = mchp_otpc_init_packets_list(otpc, &size);
>   	if (ret)
>   		return ret;
>   
> +	if (!size) {
> +		dev_warn(otpc->dev, "Cannot access OTP memory\n");
> +		if (!emul_enable)
> +			dev_info(otpc->dev, "Boot packet not programmed and emulation mode disabled\n");
> +	}
> +

And this one ^ could be squashed in a different patch?

Thank you,
Claudiu

>   	mchp_nvmem_config.dev = otpc->dev;
>   	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
>   	mchp_nvmem_config.size = size;
> diff --git a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> index f570b23165a2..5f72e75ad091 100644
> --- a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> +++ b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> @@ -4,8 +4,8 @@
>   #define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
>   
>   /*
> - * Need to have it as a multiple of 4 as NVMEM memory is registered with
> - * stride = 4.
> + * Need to have it as a multiple of 4 for the legacy id based packet
> + * access.
>    */
>   #define OTP_PKT(id)			((id) * 4)
>   

