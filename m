Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20402283FE5;
	Wed, 19 Aug 2026 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102971; cv=none; b=lOMbF7CgAfi96YpV4gXh8Gt0oQ1/1pB/mrSaS2hBwx59704Jl62DdviATYM6JHYxgyhp9ywhSM3ZLmyic2UFp0wL3W5lTxreDS+q2BW4MKNhhVRMB3yNpVbKFOOsAEz6H3B5MjoZSRUomFWhhWqiqhGymGYyFjRvKWfsA8UuozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102971; c=relaxed/simple;
	bh=AwBk0vBj97Lbb1YmygGs1fCWHyxLVWMiGBFQVMUfAzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIuhUKpVYVnKoMh2nQ/czpNVM0xYtoJmeNXPmT49/FM3UJBEY9CGmbmgjlIyy8jUNKArxjLg+z8/9IAwMJR1vq5N5sz9L58YqQ9dw2TcpfsIC0va/eD4nIwt9Y90c9wZJSl3mIpnUggMCx3YshNvY4y5RKqH8uimExw0+ujhCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCv4ixKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCv4ixKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0471F000E9;
	Wed, 19 Aug 2026 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787102970;
	bh=XRXjY4aMsc885dcywDCtqDLrAgDdMCk8h0Nh5py6QRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SCv4ixKNY9AAKimsoLvPa57rn5YfXovSOQgmlg07zHesbx09QGCb7k8/9VlnMDQEU
	 m21yFhBJgCH02Q4t3WSQ0uIvMfYTMxjkKdduaRusNLR+d84bN2s/iDegE7qqSuXNpy
	 0EQE44DZ8gAH0NFGfdKxDorYLS+KugTs42NxJAKReQ4ep/0GNY5sf122NW/gizrBxd
	 zOEUSXrD0ZlYPTg8oftjwxG1je+z4mcWdW6sx56vPNhtMZv8iV25bOeFbYiQoomDm7
	 OFIbxjKmBJKc7LKWDO1QG2O158JBfW7b6WqPlaKnfH4BhGYvPFjqAQ6v7iHPTLRQxf
	 i7OIHH5rKe5JQ==
Date: Wed, 19 Aug 2026 02:29:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: dac: ad5504: bindings, cleanups, locking,
 and scale fixes
Message-ID: <20260819022924.2eee70c1@jic23-huawei>
In-Reply-To: <20260817211118.21833-1-0rayn.dev@gmail.com>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 17:11:09 -0400
Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:

> This v4 series continues the cleanup and scale-fix work for the AD5504
> high-voltage DAC driver, addressing all outstanding feedback from the v3 review.
> 
> Jonathan Cameron applied patches 2 (sort headers alphabetically) and 4
> (introduce local dev pointer) from v3 directly to iio/testing. This series
> rebases on top of that state and does not re-send those patches.
> 
I took a look through and didn't have anything to add to Andy's
as normal excellent review. As he said, the patch descriptions are too
verbose.  It can help to ask the AI to be terse in how it describes things
+ edit what comes out to drop any stuff that is too detailed.

Jonathan
