Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136D31AA8F;
	Thu, 20 Aug 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787190049; cv=none; b=lpmYURtiZFNyR8Gy1KjOZLRulIga+xqxaL61+Jmt7dom5zNkrLunbDwP0+2ehnzpB6MQmC3miqV/ZHHbHUMypuhHi0HmGNlgWUfXB4TZMe7R0wxh4hkPtJfyM4cFTuGPOS2DXt9WbOm2HRD1o7GUhZomPYW7EhySRAd1bKgpvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787190049; c=relaxed/simple;
	bh=XdqlzmzaybKu2zkXA5dxZ3KTQqvnYAOjSULHWs0JMAU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qOJTJO8jfcece3VFt1gJBoFxZrJ7WnvQGtVgDGGf3hHZMGe06g8n6sSFu23/mkrKK23Hbqz3hCZXWe/cxtJNmY7ei0VhRBOYh5FyC/l+CQchUnL2iynn6ovxkGJhM+Sf813xMgNwtBNkxtBxE8dT29RwB78ynK1CHA8mZhuD9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkIrY0lC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkIrY0lC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022DC1F00A3A;
	Thu, 20 Aug 2026 01:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787190048;
	bh=TSuCCFfqYAA7FDlG2/zVOeaKx857nYhfp2aHgusRFvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DkIrY0lCxPzmfvfgSHqYupa9MTqjVWKIHnCWt3zoNEZDGx4zDinPrQ1l8U+6v1wIV
	 GB/fX+wg2Pz6PbL7K4h6GEAQbQDBHm9+TZGXJTfWTYohdnTJWVNVTssMoBhMZpzd3M
	 8AQ7QimN5priOxeeVXFGnhtUe1glVyjRf3As5jFBdnrtm0jdazQyqXSCpKQ8AMIIQt
	 8GHWbq6PVKiuTJ9ZGxl3m64Njjb9qQGdlb6B/I+/QvJxsmDY5IYV9ERwXM6ia5WwP0
	 xxGyDga1HBmLBus36Wpm+MDGjeKmQffqtq0cC0R8AhXNl7qI1HyYxee0ifV98i+Ghp
	 2055Z3M3UPTyw==
Date: Thu, 20 Aug 2026 02:40:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, matt@ranostay.sg,
 ~lkcamp/patches@lists.sr.ht, linux-kernel-mentees@lists.linux.dev,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] iio: proximity: move LIDAR-Lite out of
 trivial-devices and add Garmin fallback
Message-ID: <20260820024043.0c61b7f7@jic23-huawei>
In-Reply-To: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
References: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 17:55:16 -0300
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
Applied to the testing branch of iio.git.  I'll rebase that
on rc1 once available and then it will go out to be picked up by linux-next
etc. 

Thanks,

Jonathan

> Changelog:
> v6: updated Matt's email; update commit msg from patch 2;
> added myself as a second maintainer as suggested; collected
> Acked-by from Matt (patch 1) and Acked-by/Reviewed-by from Krzysztof;
> v5: https://lore.kernel.org/all/20260810192131.153495-1-rodrigo.gobbi.7@gmail.com/
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
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 71 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 71 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
> 

