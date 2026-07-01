Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0C3A4F5E;
	Wed,  1 Jul 2026 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937944; cv=none; b=HACuuYjNWauv8L9RYCecSsjwJnjJRf0mML0ACkc16JNXSwjazdeH54REkQYEBOXh+El04PDoiuRxOMSc/c7/sg1R10n4vmJPVArh9lmAzBK+3ZiRBz5djxDMtiGcV3AGT8Sa6kYbcqKan3zKeirHqrntkk9dmTrz3AzH14Ol2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937944; c=relaxed/simple;
	bh=Qe0ZV2jihiebZfb/7WbIJngX8SPw+w7+YbEQP2MGMZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F+neM6A2zM1GdYRPd8oPikkSX3EmIZ1QxfUKRRJPMYVjNV7q2Iul17XKUEIGXMH1pDRipllLAG2+s62dnUTAriKQNYiMS4oCYmibo4FxJDBg/DWL2igw5v+8+0uirWZ/UuYF2ObNt9XkcrNLojmweapfM/uHHvsQmWfnTc2AsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbcmJ35W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbcmJ35W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFA1F000E9;
	Wed,  1 Jul 2026 20:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937942;
	bh=Tj4tqAPAfPf+kza4c/5xaL2nTdzXujIQ+5IgewEZWaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jbcmJ35WqywoWDoWth2ptof5BDChc2l7KO50uXhmT2AX5RlOynJ3Gww2BeRDeK1k2
	 CHP7mJnu+2u2GmCBjYOqDN3M3qTr12y8n5pK3OYkl6Y4nTqtJGxIRP/PxNlNMQJdhn
	 U7daKY2aw27a0ACCVVkDCs2BDRfpzOMJgTESB6LD8A6JCRsQ/maqNs7wfoABLC1tR2
	 QS0ESGQCAZWnjfCmrDbkRq4d2+P2GOqqZC3jt1QJCxSYlE4Qb1FDaJbj/p1txRHWXx
	 an5Rg7WyA7u90ekKiYiimn4zTfv6iH+k7H179gXc1C/H57R2rFi/sAPKipkK9dI45+
	 J1OY96VD7qT+g==
Date: Wed, 1 Jul 2026 21:32:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 nuno.sa@analog.com, Michael.Hennerich@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 julianbraha@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 0/4] iio: adc: Add support for LTC2378 and similar
 ADCs
Message-ID: <20260701213218.6958a62e@jic23-huawei>
In-Reply-To: <a2fa4d9b-1f09-4226-8f06-371bd11ef919@baylibre.com>
References: <cover.1782397418.git.marcelo.schmitt@analog.com>
	<a2fa4d9b-1f09-4226-8f06-371bd11ef919@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jun 2026 16:39:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/25/26 9:34 AM, Marcelo Schmitt wrote:
> > This patch series adds support for LTC2378 and similar low noise, low power,
> > high speed, successive approximation register (SAR) ADCs. These ADCs are similar
> > among each other, varying mainly on the amount of precision bits, maximum sample
> > rate, and input configuration (either fully differential or pseudo-differential).
> >   
> I had a few minor comments and I suspect Sashiko found a few legitimate
> things. But this is looking really nice now.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
> 

FWIW I took a quick look as well and didn't have anything to add.
Indeed do check Sashiko though.  I didn't plough through figuring out if
the comments are valid or not.
https://sashiko.dev/#/patchset/cover.1782397418.git.marcelo.schmitt%40analog.com
