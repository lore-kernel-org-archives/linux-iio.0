Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828C748FF99;
	Fri, 18 Sep 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730833; cv=none; b=bjzzIvMRWSk9DZZD4LqC1DcGk/OTSI1aM6OS0IV5X3oHIOk+z03Vq2NTGgZ0VQfs6l6k1xoBK9N4/qHWCTeq7XDAytlsMGukoRjCmiOI1KPvcoqYpXY0p6Jr3SxdqTeVuEo0JsFF2Nw+eO4teG6WjAielQWjiE9xeaYKcM4yqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730833; c=relaxed/simple;
	bh=MTuf641jR4z9DAZ9uZUaNjh7g0R8Y2l3VjChqlVAxrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3iC5xsuuTAdNbx05k9KbWpmbPBaa8Spdj02yiaxsV2UbIpVF7bbkV2BeJ8TpKeTLJmd3lOtpX5xC3ywNGpCy1ORGc7E3ia7RiMlUUHsY6kHESq6NC6UJis92zOCKohq/teHqr09JgvIixkvrI3Mzh9VOG/7CClpQeiWMQaL4Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgdtmtbO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgdtmtbO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC71F000FF;
	Fri, 18 Sep 2026 11:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789730825;
	bh=MTuf641jR4z9DAZ9uZUaNjh7g0R8Y2l3VjChqlVAxrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZgdtmtbO37i1L9n+C4k73ZyEKfQZdLUXTgNPGrIXQyENnXEBGG9RblJBxVKCGPSc/
	 ubKiuN6HDTGptXbzh9OefaUNmzz5XAum/vtTm5KUQKHrlICBFRUPH7QTBlQFiRXmYg
	 TUPLDPMbSlV+1OPoyzS/vJ50Lk3PrdWhcctFy0HApilY/agsH7Ac3pkf8cvpoXzaU+
	 ibfYammaxYoavTyliWyZUecOQwcGiGaw1A3oxjw9lQFJ/dI3Krky6PhrhLjLeokJSb
	 0R8waxd+2q9fSddqLHyuVrooclOjfK1hVu/kKAuTQuGapi+m1WHwuvYgXiF+8yetL6
	 513t6lSd8W0yg==
Date: Fri, 18 Sep 2026 13:27:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Omer PALA <palaomer100@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: add adi,adis16203 support
Message-ID: <20260918-inescapable-crafty-cat-b03a46@quoll>
References: <20260917080905.7654-1-palaomer100@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917080905.7654-1-palaomer100@gmail.com>

On Thu, Sep 17, 2026 at 11:09:05AM +0300, Omer PALA wrote:
> Add adi,adis16203 support to adi,adis16201.yaml for
> staging adis16203 driver

Bindings are not for drivers, but nevertheless you clearly did not read
the discussions I linked in your previous post.

That's staging stuff. Are you again fixing some issues only because
checkpatch told so?

Best regards,
Krzysztof

