Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6733AD8B;
	Fri, 31 Jul 2026 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481606; cv=none; b=KTK83D+q/LOApxYcVUaiZ773+2fixptzgN7sZQTbFTmDtbg3/oeeypsylcsZlYJRwYK77GmwRikBISTn4U9N6TOg4r47jSlS5zk6+OUGzIRwjt5lGGxGwHQnmhNdPA/pVMEFRI3tHyx34Ix/3SHISXEiVhU69SwOVhuZNuozGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481606; c=relaxed/simple;
	bh=FVqvsKe/n2dYeThJDHcpjCZ9n//kHlaTzT9mHseqK1I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l4Y/urSRh4JCHaVTNDC/zTDmEimuc43aH/aUgbt7QB0MlPBSukO2m7znig5wrAsyLcdczLVcV3S9Xp7oAq490FkpXdvrQPSJGrri7WwvNCurYZ5XkssLK/Owqta/DdjB81fwNvSr3Ta3c06nr4ptLw550C07Mx/chY4r/8DiTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJy9rmAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJy9rmAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF17F1F000E9;
	Fri, 31 Jul 2026 07:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481604;
	bh=YXpVRawU4eKqO1E5kHdvQATW/LnGM3EvAkC4h7gA85Q=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=HJy9rmAGp+SLNVmA8FzS09mlNWwpiDc/dJLJq31DbdrmN+NgRBxxjsTq+Pl6a5Ji9
	 SLgVEK6L6+Yb2f/2nfVXONsjzOxFMWVl58Y4WsjNzMzBGXv8Go9QRqrHi5YY/tmy8s
	 1LOS48JbwTqd3b10uROXFW7Lrxfk7spMcnpbpfew+9urRFJ8syGimlHGTbddOjXZ8j
	 UowduSq4zN6cODohTakgTdA47Krw18WxuadTEWxu5Oh8A+3sZfi57jcw+f9pGoWwee
	 jg4P/hgSyBdPY+6d3a/7kTI7fhQzK43J3IcHpvOkC1xuIOO+IisqI2IG1dc8j71i33
	 TJDSiFj0IJxJw==
Message-ID: <f0ec8d8e-b7fe-4620-a715-65af36166e05@kernel.org>
Date: Fri, 31 Jul 2026 09:06:36 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add adi,max40080
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 ciprian.hegbeli@analog.com, siratul.islam@linux.dev,
 u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
References: <20260730131738.822405-1-stefan.popa@analog.com>
 <20260730131738.822405-2-stefan.popa@analog.com>
 <20260731-steadfast-peculiar-bee-33fec4@quoll>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260731-steadfast-peculiar-bee-33fec4@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2026 09:04, Krzysztof Kozlowski wrote:
> On Thu, Jul 30, 2026 at 04:17:37PM +0300, Stefan Popa wrote:
>> +  vdd-supply:
>> +    description: Power supply for the device.
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +    description: ALERT output for overcurrent/undervoltage threshold events.
>> +
>> +  shunt-resistor-micro-ohms:
>> +    description:
>> +      Value of the current-sense shunt resistor connected between the IN+ and
>> +      IN- inputs. Used to scale the reported current.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - shunt-resistor-micro-ohms
> 
> Supply is required
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        adc@20 {
>> +            compatible = "adi,max40080";
>> +            reg = <0x20>;
>> +            #io-channel-cells = <1>;
>> +            shunt-resistor-micro-ohms = <100000>;
>> +        };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e087673237636..e1170230c4bb2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -28893,3 +28893,11 @@ S:	Buried alive in reporters
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>  F:	*
>>  F:	*/
>> +
>> +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
> 
> Honestly, how did it appear at the end? Do you see any other
> commit/patchset adding it there? No, so this should raise questions on
> your side.

And this is quite different than v5 and nothing explains that change in
the changelog.

Use b4 prep to see what you did between revisions.

Best regards,
Krzysztof
