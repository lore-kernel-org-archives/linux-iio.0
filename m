Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62F1A9FBC;
	Sun,  2 Aug 2026 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785632335; cv=none; b=d3A+bJfBYYOuN+Y3L3tJj9IpbFKekZxL9ypFvJwVG8G0KXfr57pRlygdMX8fqgtSZ0wItxymBajBlgt6q+QU3YmuXbdI/ez52m8eb59GNm9i1NoSQTCPC7PBy1Oq7Ecy3mCJmf1/zuJhPHCxrhyXPCJsF1xlA8p5n0VLZ4ok4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785632335; c=relaxed/simple;
	bh=mwst4/82QBVacgpe0VZqtLAyJ43S+uIplS2JzU/K0dE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HvRkBcPRgy1V76HTTt6/TLh+vIO1tgT9T6pTc0qnSDU03sUdZhOAldNNQO9sEiRoOtvMdrsDFx5IIpNzdyo27ohPru/lriTEuwxDeEs2p5JmlYtdXUh3gQvZkdN6UTDZ59JBfEp0UaNOhxSfS0JkjRisAfJ7lXu+9B9AJBE+5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRMFMzRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRMFMzRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8231F00AC4;
	Sun,  2 Aug 2026 00:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785632333;
	bh=j7EcYNHdRo1EMEpjPh3jTha+pT6ubKdXhQdVcoRmFac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LRMFMzRXCk0c2fLfodiuXp8BwGu9wqqUOa980ALfMpR2UUbuDF5FhWzRZxfTgl8IW
	 SrCpuvvEmN6sk89DuwFBsO6aat8e2cLEUu3iHcg9y2ob7I6LplUW8qQdm8D/WK7cQ0
	 XwyNyL7pj+7b2JezxQkLKoIms4qJV3gSFSLZd/Qpfn0B3s9lFJ3R+7Vm4i8zFzxs2X
	 whiIIOL9XgGKsITHMO41YEOiAI1zmXwzw3oudXJzN9l3YgOcEL39B3pWvAE2WVoI1u
	 N/Bybu1HvrHENf8V2qj3YnlftEA9Bb63MoR2sZbNsT/TNF9Wz/onpCE8NFQ0bW7QKu
	 BmV8FTIJQjZug==
Date: Sun, 2 Aug 2026 01:58:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 00/17] AD9910 Direct Digital Synthesizer
Message-ID: <20260802015846.2be354ec@jic23-huawei>
In-Reply-To: <20260802010959.25f9f4df@jic23-huawei>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260802010959.25f9f4df@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 01:09:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 29 Jul 2026 09:25:27 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > This patch series adds support for the Analog Devices AD9910 DDS.
> >   
> Series applied with that small Kconfig help tweak and a bit of fuzz
> around the new channel type due to the flow sensor I merged earlier today.
And dropped again :( See patch 11 reply.

> 
> Thanks,
> 
> Jonathan
> 

