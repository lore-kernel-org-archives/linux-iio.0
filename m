Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FC3A0B3B;
	Tue, 11 Aug 2026 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433888; cv=none; b=HlNn3Uz2moVWNjMdYdsKELY2AQUHMZp+I6zEWPHJOnRtyz4iqUODSoVOKZ4qvGYQed8HAvB7zaT3uDyMvfsgKKs6NF1GURn8Mbew6/uwu3IzBACLTko5K2DizuqUqDB8kZucGMAexlzhnCsNwaYNtkXfCaFOvQg3FNx1OgGsFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433888; c=relaxed/simple;
	bh=tJSaX1LR6XBoX9vpISSI7f1T5XWMn7evQmQPaS2mQYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoAvBnYIJlbUPm+6w3UVWXvtOQdD58voQZWQyhgntgqQbq9SePY8xK4OfSHXZ71rJCYXZlOUGc11NDVy7vW3vEJYro4uaK99lDQpynlukQMOkGttgJ/PWN5jtgkVy9hqoyuaqWybZ2llxvFSgT0nm0DFzOjmR6ZLQeXqYRfxZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOKR7XJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOKR7XJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9D61F000E9;
	Tue, 11 Aug 2026 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786433886;
	bh=tJSaX1LR6XBoX9vpISSI7f1T5XWMn7evQmQPaS2mQYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dOKR7XJxXI0uDpDcxk+9/IsuRuvo29sdlW/T+ZN7nVvh5fCvE91WCZt1g38tSV340
	 q6u7BnzQWDvRB1aIkX9q0xJGdkvhsSeWkVvisf0G86kuJk7zYzEWKTkQk0YCvyAaAi
	 WDQQXwAnns4IKs+3QrPyI6OAoOMvFXRhW2ZHMmvxZ5hg5SrjZ8SVHIRl/vC4Y62GEs
	 piBJUdTgR9XeSLHUERoE9KK/jE5e1Ewpn1m5s89IBsJID1pDI3uYwK71Ii0IGY47Ib
	 Lq+Zsmg+C3ntaeH3igoWCaDWIHrEn+ZFn1+LItuC2YuRt3vXylEC6CRuPzfAnMT3lz
	 2/TxrcTMJDhSw==
Date: Tue, 11 Aug 2026 09:38:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht, 
	linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: iio: proximity: document LIDAR-Lite
 v3 fallback compatible
Message-ID: <20260811-chubby-prudent-serpent-bdf1cf@quoll>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
 <20260810192131.153495-3-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810192131.153495-3-rodrigo.gobbi.7@gmail.com>

On Mon, Aug 10, 2026 at 04:18:41PM -0300, Rodrigo Gobbi wrote:
> PulsedLight was acquired by Garmin, who now sells the LIDAR-Lite v3.
> It is pin-compatible with the v2, and the driver already matches it
> directly: commit b257c1a45e99 ("iio: pulsedlight-lidar-lite-v2: add
> lidar-lite-v3 property") added a "grmn,lidar-lite-v3" of_device_id
> entry, so no driver changes are needed here.

Drop ", so no driver..." - that is not really relevant.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

