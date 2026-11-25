Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.52.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578950;
	b=zGWhK3eUJNm7rLyRpVWA2wyPbzEY4LkHnUDO4GTXKaldEHHM0f/+Y9mHtNxIwquHHvZz
	 J55AbFeZwylEz7NJLrANgDAlcXinAGSHb3RFCCrPHW8UpJ25l/bDFYhjwcO2d6LpodqdS
	 iOBOhC6Mz6VKC2zLg72FrJLPQE7eFqME6JaAlSrp36B49pWXFau13CL4bQtu/Z7RCo5Pk
	 zjpV85Q5LFjjIHOxbr1NsG94IiYmhjq3AHSN7IBGgJvyKVGSI/xVOgYcTzsOs4p6sFK71
	 L506vDioe4UO6d+X94fK3jHnkCVgg4gNDuKQho5c9Xd4fn/F5eFodzLmaisXq4lUnZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578950;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=vBiVRAr+5XLhivQmL9zYbZRsjiirfBfGSpOjwM03dXk=;
	b=PE08/7CrHmZYpg/Qq/07Pac+4tOOWk511t1Fl9FRspimi8tqEFjI9AzVSxUvCTJjQPeh
	 m7KXtz1ohvWod1GpmFtJljyTOIQoN6bJ2Gcvyy5qfODrHQGkmvxl5AZA7aJHte4rK2YU6
	 kxiB2GDL8YG+7l8cF64+0B0IZ9nZSo+OJCYG3DymB5r3kpkhjvmg8Sg3WOAe8t6TizBtc
	 0MxyXSt/bWt3vWdnT1rozkelfoHuo3w0TbfHJwrGqmI7jksKy564gxMIX+MIufDLHSXZg
	 BezMJKGe4N6shXOHgk1N5XXXCxvCzsX1nMSXUBtBp6VJZ3wL/IMw6MqF5nSk8CYQ42Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b="Ph+hLG/U";
	arc=none smtp.remote-ip=160.236.52.120
Received: from mail-m16023652120.xmail.ntesmail.com (mail-m16023652120.xmail.ntesmail.com [160.236.52.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7AC606A31E;
	Wed, 25 Nov 2026 03:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B7AC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Ph+hLG/U
Received: from [172.16.12.74] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55e7c8e52;
	Wed, 25 Nov 2026 11:55:34 +0800 (GMT+08:00)
Message-ID: <68d54499-044c-45af-abbb-9aa7bc212db5@rock-chips.com>
Date: Wed, 25 Nov 2026 11:55:34 +0800
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] dt-bindings: pwm: Add a new binding for
 rockchip,rk3576-pwm
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee@kernel.org>,
 William Breathitt Gray <wbg@kernel.org>, kernel@collabora.com,
 Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@gmail.com>,
 linux-rockchip@lists.infradead.org, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 "chaoyi.chen" <chaoyi.chen@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-1-ae7cfbbe5427@collabora.com>
 <alCvmLX1ke0qjh99@monoceros>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <alCvmLX1ke0qjh99@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa210d8360203a8kunm11819cac735762
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh1MHlZLSh9KQh1DHU
	9JTk5WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Ph+hLG/U/ehuFm1xORwAyVx8Z1h6dMUvRnaVJgrJQMVC1NWYy35lbIWmv5ub87pk4Xpwltj0cIRfK5iIWecdEokKUXIWS1h21FPK1MIlOBLf2n0Hz8Hso6BG8hOGyBIbwU+5Xefao0dS8yLtSFthl5iNKmq2pQN8EdSpwUOhYs8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=vBiVRAr+5XLhivQmL9zYbZRsjiirfBfGSpOjwM03dXk=;
	h=date:mime-version:subject:message-id:from;

Hello all,

On 7/10/2026 6:31 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Apr 20, 2026 at 03:52:38PM +0200, Nicolas Frattaroli wrote:
>> The Rockchip RK3576 SoC has a newer PWM controller IP revision than
>> previous Rockchip SoCs. This IP, called "PWMv4" by Rockchip, introduces
>> several new features, and consequently differs in its bindings.
>>
>> Instead of expanding the ever-growing rockchip-pwm binding that already
>> has an if-condition, add an entirely new binding to handle this.
>>
>> There are two additional clocks, "osc" and "rc". These are available for
>> every PWM instance, and the PWM hardware can switch between the "pwm",
>> "osc" and "rc" clock at runtime.
>>
>> The PWM controller also comes with an interrupt now. This interrupt is
>> used to signal various conditions.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> ---
>>   .../bindings/pwm/rockchip,rk3576-pwm.yaml          | 77 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  7 ++
>>   2 files changed, 84 insertions(+)
>>

With Nicolas' agreement, I'm planning to take over the RK3576 PWM v4
support work and to restructure the driver to a certain extent.

The RK3576 PWM v4 revision actually provides a large number of
features, such as counter, frequency meter, biphasic (AB) counter, IR
transmitter and IR receiver. All of these features share the same
physical address range. Features that appear unrelated to "PWM" have
been folded into a single PWM block (due to some unavoidable
constraints). In a future v5 revision these features will be split
into separate blocks, each with its own physical address range. This
is the main reason I would like to restructure the driver layout now:
an MFD based v4 driver would have to be reworked into a non-MFD one
for v5 anyway, which would leave us with two drivers duplicating the
same logic.

Nicolas' MFD version is an excellent implementation for runtime
feature switching, but by design intent we prefer the function to be
fixed at hardware design time, i.e. a static selection instead. I have
found two similar existing implementations:

1. TI's eCAP module switches between functions by overriding the
    compatible:

    drivers/counter/ti-ecap-capture.c
    drivers/pwm/pwm-tiecap.c
    Documentation/devicetree/bindings/counter/ti,am62-ecap-capture.yaml
    Documentation/devicetree/bindings/pwm/pwm-tiecap.yaml

2. Samsung's USI module, which Sascha pointed me to, uses a top-level
    node matching the USI driver with one child node per function
    (disabled by default). The board dts then only has to enable the
    child node it wants to use:

    drivers/soc/samsung/exynos-usi.c
    Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml

I would very much appreciate your feedback on this, as your opinion is
key to making sure this restructure does not head in the wrong
direction.

For reference, the planned work is:

1. Settle on a static DTS method to select the PWM v4 features.
2. Merge the PWM v4 support into the existing pwm-rockchip.c driver,
    based on [v5,3/6] pwm: Add rockchip PWMv4 driver. For v4 the
    waveform API already adapted by Nicolas will be used (older
    revisions will be migrated to the waveform API in the future).
3. Add a separate counter driver for the PWM capture function, based
    on [v5,4/6] counter: Add rockchip-pwm-capture driver.

---- (second stage) ----

4. Add a rockchip-cfd.c driver based on the Generic Counter framework,
    supporting the frequency meter and the counter.
5. Add a rockchip-pcd.c driver based on the Generic Counter framework,
    supporting the biphasic (AB) counter.
6. Add a rockchip-ir-tx.c driver based on the RC framework, supporting
    IR TX.
7. Add a rockchip-ir-rx.c driver based on the RC framework, supporting
    IR RX.

Best regards,
Damon

