Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B157352029
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538493; cv=none; b=jZYnJBH2/VkGVvm8rnOiHjARBhefQeVfpAAHzIPGRkNGZ9WC58Y54e3i+LSVfuPzv93c8c/UT1aY3hFTjpHSZYlrEsXTbr1YvS+kDLugqn/qM0GqRRfMWhSslwFUCkpUCAG7weLT82zxy1hKAZJC6CPV4FZ7tyEI8AvCPC36Meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538493; c=relaxed/simple;
	bh=S2iivv0OCUFj7r6dflGwy5lbMAWvtCa62u36edHKWdM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QApFbBNn9/D433v3MPpZ9rzgiGWWXRW2C0JxjJLVssv1nd6jKMYlWF+7AzsKmd3UWN86lHh87PkhfgSP2dqQyCxgJ/LiJEeL+OHTaGpsrZDAf7i+/a3qyjA62r/bWDE5mGunzwzEti9deCaQFZovhn4vi7YbdPVT5pz2ovFhl+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=wphoB4YS; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="wphoB4YS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786538478; x=1786797678;
	bh=YxWA8tiQCMavv9N3+KTJRnlp3LNFrP04pwpm0fRKjHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wphoB4YShsx8O72HP51VDksd28JKGDzkXTJAEW0rZ9DlFVMdrUQKbGkQ05CXUdrNT
	 QMPcvSM1L7kpqKQ4tgu8UWvLKQ1wjhJ/Kl1ZtU+si/Yrdh0IC2wU1W3Lin+4FZCDAj
	 d7rvtymCp0xDl6d3IMNI+nAWwXK+9pw2CLhEoRwHDc7tTnkhDIvE1m/X5dFJzEphyE
	 qkAsrfDh8Eax95YfFlBxLwgebrguUj3T7cuJkXh2qIG8+UcXeewm7obNCCKpMvIwLr
	 vTorsNSyO/zO214WTiA6pdcrBnTiKa6xKiqL/SHkR7hOUrWmPXTVvLcTLVkMkMjlw9
	 /9rgCOoi/fu5w==
X-Pm-Submission-Id: 4hKp5761nrz1DFFG
From: Esben Haabendal <esben@geanix.com>
To: "Rob Herring" <robh@kernel.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>,  "David Lechner"
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  "Andy Shevchenko"
 <andy@kernel.org>,  "Krzysztof Kozlowski" <krzk+dt@kernel.org>,  "Conor
 Dooley" <conor+dt@kernel.org>,  "Nikita Travkin" <nikita@trvn.ru>,
  "Maslov Dmitry" <maslovdmitry@seeed.cc>,  "Kuppuswamy Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>,  "Thomas Gleixner"
 <tglx@kernel.org>,  "Pan Chuang" <panchuang@vivo.com>,  "Yangtao Li"
 <frank.li@vivo.com>,  <linux-iio@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 3/7] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
In-Reply-To: <20260810155006.GA1815611-robh@kernel.org> (Rob Herring's message
	of "Mon, 10 Aug 2026 10:50:06 -0500")
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
	<20260810-liteon-ltr329-v4-3-8bd3dfd15280@geanix.com>
	<lLSnPCriXSWAjaV4ogTOt4280Fj7hoZxBDkJC70ETVjxbUYNhCi8Ii6pDv-7YQ5SKb_Hz4Aj4JwtYPGwPH6WwA==@protonmail.internalid>
	<20260810155006.GA1815611-robh@kernel.org>
Date: Wed, 12 Aug 2026 14:41:14 +0200
Message-ID: <871pc3y0id.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Rob Herring" <robh@kernel.org> writes:

> On Mon, Aug 10, 2026 at 09:11:13AM +0200, Esben Haabendal wrote:
>> LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
>> without interrupt support.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>
> sashiko issue should be addressed.

I will.

I guess it is best to add the new conditional statement under allOf, but
as we already have an allOf block at the top, I would have to add it
under that, which would place this new conditional statement related to
specific compatible strings before the list of those compatible strings.

It should work fine, but it looks a bit odd to me.

I could also add it directly  as an if statement, but that would only
work as long as it is the only top level if statement, so that looks
like a bad idea.

Should I just stick it to the existing allOf list?

/Esben
