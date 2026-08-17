Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0741E2C326D;
	Mon, 17 Aug 2026 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933562; cv=none; b=J/LPSYVX+0HxAK7A8YHLqi4d6fi6TagLvxrNOOPX+UgK87YSLfxG7mmFdEeaL2qWyNL67GF3J65INk+kZwgFksLuFMNLkGyH9fmoGPkK8NDqoXa8dZpOabXu/9qSXuLOKtddzlTYYBNs4kY96p8ukpdpvfZN4Dr/bs1OdmgoVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933562; c=relaxed/simple;
	bh=vpWvs3/KWV0E7QsvjE/aQojofGn0pvJkVr0xAwTFppA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+d5jI1blVNdznBBudniQ+eSLLAsjGtgpyhiuha6J2HlQB9Yjy5efQYqfjL3ZEnpDThRpwPI0BBlMau9EwWWNHGAgOsPB5ZxEEcojPwKXx5dcILBIP4zGt2iUQx2Q2VBV23sFVjy5fFNBO9VUzUL/4EucMqxPlEy/KoGEF+6YRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5xzTENA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5xzTENA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EB51F000E9;
	Mon, 17 Aug 2026 02:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786933560;
	bh=WgqUVZHhHkr7Mok5OB8xen4dfW9N5ijCeONfcS2eng8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M5xzTENAtQDahv++npkCXetOWV0GmXby03pViQh0jtGut8wjM4pUhKwiIbdr7+Gtq
	 jWGdKqG8+d5aIPgS9Wd5DTNmRgerZhpEIelsN37Aj6OICbyvxWSkQOURb4wNra4ZNY
	 01tdYQl2CR4/bzjJ6E5IJxcMBueNRa71feYU0h50uYJj6xJK9+IRTVyb8ITakPTaNH
	 Ezf+l8k/DEvIL8JEwHvz7XQyZTmlxEGlfbP3t3DqaxJtLjCnXAqezsOYnrDZ9Cee8O
	 Q6+mZScDEbv0TqyDBz2nl6a6u0lynYKP+5Z7wQuUREUui3s5X0LWwfPCD8Wn8z7CUs
	 JxBvBzftbfStQ==
Date: Mon, 17 Aug 2026 03:25:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht,
 linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] iio: proximity: move LIDAR-Lite out of
 trivial-devices and add Garmin fallback
Message-ID: <20260817032552.63c04216@jic23-huawei>
In-Reply-To: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 16:18:39 -0300
Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:

> This series moves the LIDAR-Lite v2 binding out of trivial-devices
> into a dedicated schema, documenting the power-enable, power-supply
> and status-output interrupt properties that trivial-devices.yaml has
> no way to express.
> 
> It then adds the Garmin LIDAR-Lite v3 as a fallback compatible in a
> separate patch, since it is pin-compatible with the v2 and already
> matched by the driver, so no driver changes are needed.
> ---
Just enough stuff in here that I think a v6 tidying up (and hopefully
getting a tag from Matt) would be better than me trying to do
it as part of applying.

As such I've marked it changes requested in patchwork.

Jonathan

> Changelog:
> v5:
>   - split into two commits, one for moving lidar out of trivial and
>   one for adding a fallback compatible for LIDAR-Lite v3;
>   - minor changes at yaml like: title, description, adding irq prop;
>   - improve commit msgs for covering the vendor acquisition and PWM mode;
> v4: https://lore.kernel.org/all/20260714215433.41259-1-rodrigo.gobbi.7@gmail.com/
> v3: https://lore.kernel.org/all/20251102221643.9966-1-rodrigo.gobbi.7@gmail.com/
> v2: https://lore.kernel.org/all/20250801224112.135918-1-rodrigo.gobbi.7@gmail.com/
> v1: https://lore.kernel.org/all/20250701223341.36835-1-rodrigo.gobbi.7@gmail.com/
> ---
> Rodrigo Gobbi (2):
>   dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
>   dt-bindings: iio: proximity: document LIDAR-Lite v3 fallback
>     compatible
> 
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 70 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 70 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 

