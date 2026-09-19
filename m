Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD771D4606
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823844; cv=none; b=IElXfAOMPOzAw2C9gAjp395w8ce0f6mrdn15pwyIlHWdIEMqLQPMn4NS+W/x15y0M3WA5f4U/1CM+HAEJt9bKkoJzVyv9AhqiwNwZPDOg30ESYM6UxOyhAQQE6MSDr7LY7dP3ZyRH9p3QySAyv31Vn+GV1Ai95J7i93e09vd0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823844; c=relaxed/simple;
	bh=aqylDhL4FHnDrafOW29rnfMJpBekGNDUuBZoAIIACQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sm7H2x019UCppVeFz/Z3uEmgs1m4nGKAJCiumlgUu/r6kH6wxpZZXAelNITya1yAOsPKd8L7kq8bwQV6SxzZa/ScojYIdwFszNQxYwYjbilC0RtwEzpG5gvS9ZadSOWN8V8qZ4eGAF07+Xuiw1Kn7K3vKMn8xGqSAfug2cCGylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qp4RYIFs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qp4RYIFs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so15866765e9.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789823840; x=1790428640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=arsuenBaXtBMqazzptjgRYvEzzXZ3cFNtGq2cAJLhn8=;
        b=qp4RYIFsV8Umw5i3fqlPg4JnILifOvcqa/qLUkCMna8koIoTwHC7emvsJN1KKgTUzM
         TR8cMJw/3co4vkIkGRLIJDOZH8dIuJDemZMiimLHxTrztiKeq9g8dF7fzNmQKCFAPH+C
         wAY9yA+R2iRuURvBGOEIG2qob9kiDdpuXDgez1od6cE/fKeOzQCpTFGw3E+JgOFCGzFj
         DBo4ZK6yq9qnWGsayK34Kbhfxv0EYyUGFTQFgS8eW1G4zhxCFixjNGT29c3CbFH3xbNd
         zJKd2uqkggHPqbOnB2hs8k6opbxXUiFMT4KAOcqaMdXrHhwHyoaj7POUqhF6Z2vCULTD
         kFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789823840; x=1790428640;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=arsuenBaXtBMqazzptjgRYvEzzXZ3cFNtGq2cAJLhn8=;
        b=MFK1s04jhA2rPaJk5WPYhaS+ZCqWgWNMEmHSSTzcrvbJrM4nvH1EQ9PFdxg+G6m3C7
         eJ3dO6fftLh1R8MCXzmBnqs4rEVHzAkvartwmtvoZ8Yrf7/3DXXxdtidWhw3M4L3KLYX
         XAx8lM1vXGgfWbtQxU1a6ryQTMpN9VpRZETBAQuMsONopfz927RFF93MTrH3Fe1EP5i1
         LmwzQ/9rw2+4BDwwmohH5WaQa0Z2sVqO9S9h2TdNFIu2uCDXlpLUvflUcVXAe3dX2IB1
         40hjKShAEgFcifSNUTocFrd1OL9Kid+jicVczbb62qSfPTi4nIS2XiOdGZfjyW1T2GXd
         /wBA==
X-Forwarded-Encrypted: i=1; AKwUvBxc9ESap53ftUK+93nJyJsVnbl5QRCfpMi6ZEC+9jVw/slsK8u61UdgZO+7MjihwGqQpKhP3f3RrPc=@vger.kernel.org
X-Gm-Message-State: AFuF++mYjcSN15+MHkt6s7RUdOI/hYRHKGEinWd+xCZTN3QzCr1jjUlb
	kLU/905sXIKY0wNW8s4WCH/dPgfjIOfeW2wda8EDSZMBzM+TX86/CwDyPpWp3Pd7z/xIKITKrqi
	Ij7gCCJY=
X-Gm-Gg: AYBFou3LkfrB+1IyJgt4Bb52/rs20hgI5WVKZDGpLTNe1GbalLDqhJGPZ+cBMP1Nb2/
	qvMmQNGX2dvreHyj6b0YPrKIaQkKllohgqZjbhAUwdxejmKYciaHPk9KqAztsp0SB+30nt6NRPd
	efTw/WBkzZd5OVNo81EBxGzi1b7aud9fWg8bI0/L8TDQr0BbhRk7vpX3lE6YLIUDViGOjgwP+7+
	VY14TBV8Vb8fy178J2Sj6WSbzMWpvWIdbK98pkdQIAVK0e8m98S8wGeg2j47yGZmv9xzSW8/8NK
	kISR+Hop0KoCwTwYPcZCpxtAYh9ilnwaursa3OrAxblWho82ZZszwFr0gMa7alj8KEdO0+mS2Lc
	qSdGpT+KskfIjlLx7GCxfpmV1rwpyLJEch2+1rvX35tu7S21nNnBQHbNU8+KZzShOT1LMFnU/nT
	3dCs40GGTDU6NU+DoCaU6I7HwBrUWVeUeVLpGsIeZKEc78x4qv0tms259iPPalEg75w1SEMBt6w
	1Ped9tggmTFXxPJaAfzic4EYTYcSusbfiO6oDzeJu6g3/49kWYo4P0upz65I5hGTg0i
X-Received: by 2002:a05:600c:3f0b:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49fc56aa68amr77388855e9.8.1789823839836;
        Sat, 19 Sep 2026 06:17:19 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0ece6esm103469825e9.2.2026.09.19.06.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:17:18 -0700 (PDT)
Message-ID: <a5f22eff-5d5f-405d-86fe-471e522ce602@tuxon.dev>
Date: Sat, 19 Sep 2026 16:17:16 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/17] nvmem: microchip-otpc: nvmem: microchip-otpc:
 add tag-based packet lookup
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 radu.sabau@analog.com, joshua.crofts1@gmail.com, jorge.marques@analog.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-10-varshini.rajendran@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260806074024.531259-10-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 8/6/26 10:40, Varshini Rajendran wrote:
> Add support for accessing OTP packets by their tag which is a FourCC
> while preserving backward compatibility with the existing ID-based
> lookup.
> 
> The OTP memory layout can vary across devices and may change over time,
> making the packet ID approach unreliable when the memory map is not
> known in advance. The packet tag provides a reliable way to identify
> and access packets without prior knowledge of the OTP memory layout.
> 
> Two offset encodings are now supported:
>    1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
>       Used in DT as: reg = <OTP_PKT(1) 76>;
>    2. TAG-based: offset = 4-byte ASCII packet tag (FourCC)
>       Used in DT as: reg = <0x41435354 0x4c>; (tag "ACST")
> 
> The driver resolves offsets matching valid legacy selectors (multiples
> of 4 within the packet count) through ID lookup, falling back to tag
> lookup for other valid values. This ensures existing device trees
> continue to work while enabling new tag-based access. During probe,
> packet meta data including the tag is read and cached.
> 
> The stride of the nvmem memory is set to 1 in order to support tag based
> offsets, comment in the header file is updated accordingly.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>   drivers/nvmem/microchip-otpc.c                | 117 ++++++++++++++++--
>   .../nvmem/microchip,sama7g5-otpc.h            |   4 +-
>   2 files changed, 110 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index df979e8549fd..a17f82afdc37 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -23,6 +23,8 @@
>   #define MCHP_OTPC_SR_READ		BIT(6)
>   #define MCHP_OTPC_HR			(0x20)
>   #define MCHP_OTPC_HR_SIZE		GENMASK(15, 8)
> +#define MCHP_OTPC_HR_PACKET		GENMASK(2, 0)
> +#define MCHP_OTPC_HR_PACKET_REGULAR	1
>   #define MCHP_OTPC_DR			(0x24)
>   
>   #define MCHP_OTPC_NAME			"mchp-otpc"
> @@ -47,11 +49,13 @@ struct mchp_otpc {
>    * @list: list head
>    * @id: packet ID
>    * @offset: packet offset (in words) in OTP memory
> + * @tag: 4-byte ASCII (FourCC) tag of the packet
>    */
>   struct mchp_otpc_packet {
>   	struct list_head list;
>   	u32 id;
>   	u32 offset;
> +	u32 tag;
>   };
>   
>   static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
> @@ -70,6 +74,52 @@ static struct mchp_otpc_packet *mchp_otpc_id_to_packet(struct mchp_otpc *otpc,
>   	return NULL;
>   }
>   
> +static struct mchp_otpc_packet *mchp_otpc_tag_to_packet(struct mchp_otpc *otpc, u32 tag)
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
> +static bool mchp_otpc_is_valid_fourcc(u32 tag)
> +{
> +	int i;
> +	u8 c;
> +
> +	for (i = 0; i < 4; i++) {
> +		c = (tag >> (i * 8)) & 0xff;
> +		if (c < 0x20 || c > 0x7e)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static struct mchp_otpc_packet *mchp_otpc_resolve_packet(struct mchp_otpc *otpc, u32 off)
> +{
> +	/*
> +	 * Legacy id based packet access: offset = id * 4
> +	 * Inside the driver we use continuous unsigned integer numbers
> +	 * for packet id, thus divide off by 4 before passing it to
> +	 * mchp_otpc_id_to_packet().
> +	 */
> +	u32 remainder = off % 4;
> +	u32 id = off / 4;
> +
> +	if (!remainder && id < otpc->npackets)
> +		return mchp_otpc_id_to_packet(otpc, id);
> +
> +	/*
> +	 * TAG-based packet access: offset is a 4-byte ASCII tag (FourCC)
> +	 */
> +	return mchp_otpc_tag_to_packet(otpc, off);
> +}
> +
>   static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>   				  unsigned int offset)
>   {
> @@ -140,8 +190,29 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>    * offset returned by hardware.
>    *
>    * For this, the read function will return the first requested bytes in the
> - * packet. The user will have to be aware of the memory footprint before doing
> - * the read request.
> + * packet.
> + *
> + * Two offset encodings are supported:
> + *
> + * 1. Legacy ID-based: offset = OTP_PKT(id) = id * 4
> + *    Used in DT as: reg = <OTP_PKT(1) 76>;
> + * 2. TAG-based: offset = 4-byte ASCII packet tag (FourCC)
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
> + * ASCII value (FourCC), the packets can be recognized without being aware of the
> + * flashed OTP memory map table and the payload can be acquired reliably.
> + *
> + * While the legacy ID based lookup is still supported, TAG based approach is
> + * recommended.
>    */
>   static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>   			  size_t bytes)
> @@ -154,12 +225,11 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
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
> @@ -190,10 +260,25 @@ static int mchp_otpc_read(void *priv, unsigned int off, void *val,
>   	return 0;
>   }
>   
> +static int mchp_otpc_read_packet_tag(struct mchp_otpc *otpc, unsigned int offset,
> +				     unsigned int *tag)
> +{
> +	int ret;
> +
> +	ret = mchp_otpc_prepare_read(otpc, offset);

Is this needed? At the moment this function is called a prepared was already 
done (in mchp_otpc_init_packets_list()). The header was read. As of the current 
code from mchp_otpc_read(), after that, writing 0 (for DR increment) to AR and 
then reading DR leads to successfully reading the DR.

However, the manual [1] mentions the following on step 4 from chapter 37.5.3.5. 
Read:

4/ Read the header of the packet in the OTPC_HR register. To read each payload
    word, the *address of the payload* word must be written in OTPC_AR.DADDR. The
    payload word is then available in OTPC_DR. If OTPC_AR.INCRT is set to
    AFTER_READ, any read in the OTPC_DR increments the DADDR field.

So, maybe there is a bug in the current code, in the mcp_otpc_read() and this 
function, and instead of writing 0 to AR, after reading the header we need to 
write the AR.ADDR and INCR=0 and after that read the DR? And the HW happens to 
behave correctly even with the current implemented approach?

[1] 
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7D6-Series-Data-Sheet-DS60001851.pdf
> +	if (ret)
> +		return ret;
> +
> +	writel_relaxed(0, otpc->base + MCHP_OTPC_AR);
> +	*tag = readl_relaxed(otpc->base + MCHP_OTPC_DR);
> +
> +	return 0;
> +}
> +
>   static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>   {
>   	struct mchp_otpc_packet *packet;
> -	u32 word, word_pos = 0, id = 0, npackets = 0, payload_size;
> +	u32 word, word_pos = 0, id = 0, npackets = 0, payload_size, type;
>   	int ret;
>   
>   	INIT_LIST_HEAD(&otpc->packets);
> @@ -215,6 +300,20 @@ static int mchp_otpc_init_packets_list(struct mchp_otpc *otpc, u32 *size)
>   
>   		packet->id = id++;
>   		packet->offset = word_pos;
> +		type = FIELD_GET(MCHP_OTPC_HR_PACKET, word);
> +
> +		if (type == MCHP_OTPC_HR_PACKET_REGULAR) {
> +			ret = mchp_otpc_read_packet_tag(otpc, packet->offset,
> +							&packet->tag);
> +			if (ret)
> +				return ret;
> +
> +			if (!mchp_otpc_is_valid_fourcc(packet->tag))
> +				packet->tag = 0;
> +		} else {
> +			packet->tag = 0;
> +		}

The else path is not needed since packet is allocated with devm_kzalloc(). With 
that, if the above is true this section could be written as:

if (type == MCHP_OTPC_HR_PACKET_REGULAR) {
	u32 tag;

	writel_relaxed(packet->offset + 4, otpc->base + MCHP_OTPC_AR);
	// or if the manual is wrong:
	// writel_relaxed(0, otpc->base + MCHP_OTPC_AR);
	tag = readl_relaxed(otpc->base + MCHP_OTPC_DR);

	if (mchp_otpc_is_valid_fourcc(tag))
		packet->tag = tag;
}

Thank you,
Claudiu
