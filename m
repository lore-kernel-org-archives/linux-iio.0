Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EB638AC61;
	Wed, 12 Aug 2026 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786505727; cv=none; b=H2Sies8OuO5NGezphDzjs/bLjUqZ7IB94rbc4pv8zWVciblpuMw7U96TB8KcaptEiSsauE2N2zpCazuzNR/hsQCP8/IBiLts7g2ezRKGGQCSfIU/AH4px6yMxtrk7HmdT8lVfYr+0aH2xfBK1ReQCl4Ri269rcztqwimgNrj28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786505727; c=relaxed/simple;
	bh=Ebn6mymE00VaspS46aolJ6BfdorVNylfW7/20RscPQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/cFz0wilGMQNOPMRXNecSIswqQ5+V0dHx98YQAOHjlkHMitnXObTj6j8ZSK+PMT3YRFzuVwdQm6Ot1onMZhyHVczlHgOgQebN/qBVUs6glE2KKeu2HVhu3fw5aoknyC4l+z+OUitsKFjzVJpOoh5I3L9ikVlQBFmhlga1WgaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/N+QIXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/N+QIXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1480D1F00A3A;
	Wed, 12 Aug 2026 03:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786505721;
	bh=P5Iw3jrI2i0RShDzNBNNbnwSP8PKwenDHPRy32NC0QY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i/N+QIXTw1Lj5YbEUShSSdRdYvOtQ2PjYYD78LQXDxw9pfsMKZ2Q9f0TqiKIFumoH
	 R918TIm0ch0jQWyyWB0NBiY8qFKhBkKhGC/adH0mE5H0R7UqtLPfwvkLhtb+ZsZP0R
	 /VRcBEU6b15E6tkCPJafRBJQ9m6SjV/IA4pM1cXR3QF1Y4mNTkcJq5rJNL4Ok6cKr6
	 V4EFbhGBISbjDtFdA4JWpHExW3MUDNt1zUUy7rgwEspEKZVrpBMH7iSMuhq9AqsRj6
	 3FW7qWXxEj8Ns7h34Dl8hhVhbDxiF5lKkTKjqZqSMrv8rIPo/ySyDQGIzn8NlINY3x
	 9dxg7+EaMCtfg==
Date: Wed, 12 Aug 2026 04:35:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux@analog.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: accel: adi,adis16201: add adis16203
 compatible
Message-ID: <20260812043506.456ced6d@jic23-huawei>
In-Reply-To: <20260812015421.GA498537-robh@kernel.org>
References: <20260805102224.3547-1-shehryar.amd@gmail.com>
	<20260812015421.GA498537-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 20:54:21 -0500
Rob Herring <robh@kernel.org> wrote:

> On Wed, Aug 05, 2026 at 03:22:24PM +0500, Shehryar Ahmad wrote:
> > The ADIS16203 has the same external interface as the already
> > documented ADIS16201/ADIS16209, for the properties covered by this
> > binding (compatible/reg, the DIO-based interrupt pin, and VDD
> > supply), verified by datasheets Table 5, Pin Function Descriptions,
> > in the respective Analog Devices datasheets. Some Auxiliary pins
> > differ (e.g. adis16209 marks a few pins DNC where adis16201/adis16203
> > use them as AUX COM), but these are not represented in this binding.
> > Add adis16203 to the existing enum rather than creating a separate
> > file.
> > 
> > Tested with checkpatch.pl --strict and dt_binding_check; both pass
> > with no warnings.  
> 
> This is assumed, no need to record it forever in the commit.
> 
> > Three prior attempts to document this part are visible on the
> > mailing list, all as separate files, each redirected toward this
> > existing binding approach instead: Saalim Quadri, March 2025 [2],
> > and Sheng Kun Chang, April 2026 [3]. See below for Jonathan
> > Cameron's earlier, related attempt [1].

Key thing here is that we generally don't take bindings for drivers
that are in staging and adis16203 remains there.

This patch looks good for when/if the driver is moved out of
staging.  There have been various series on list for that so
perhaps ask those authors what current status is (just reply
to that series).

e.g. 

https://lore.kernel.org/linux-iio/20260401162458.88110-1-nothingchang@mirrorstack.ai/

Which is the parent of the last link below and I think the last of
various attempts to do this.

Jonathan

> > 
> > A richer version adding reset-gpios and a second interrupt
> > (interrupt-names: dio0/dio1) was proposed by Jonathan Cameron in
> > 2023 [1]. I tested the same additions locally for all three
> > parts; checkpatch and dt_binding_check both pass. It is not
> > included here, as it hasn't been verified against any real board
> > dts file, and none in-tree currently reference adis16201,
> > adis16203, or adis16209. Can send that as a follow-up if
> > wanted.
> > 
> > Link: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230129155602.740743-13-jic23@kernel.org/
> > Link: https://lore.kernel.org/all/5390c973-6a92-4de8-b00a-cd62af347ccb@kernel.org/
> > Link: https://lore.kernel.org/all/20260402-fair-wakeful-okapi-3c6dba@quoll/  
> 
> Thanks for the history. It should be after the '---' so it too is not 
> recorded in the commit.
> 
> > 
> > Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> > ---
> >  .../devicetree/bindings/iio/accel/adi,adis16201.yaml        | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)  
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


