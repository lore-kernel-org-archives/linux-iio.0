Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27D03C9EE5;
	Sun, 26 Jul 2026 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785093135; cv=none; b=f6M6HJs1Jtli/2E1jibqV/eGTza2b9YTmdFf4sURLzoWeS4vVvGEqrMR32c5+/m41rcyxkIzOwafFG3+vMT0zMheWB1P1p5R5MB5S2l8PX25YVRUWv9dWVIsPwbby3+oKtj2mz7VpLuemSq6mDw6rKvtxPEd+7HP6XOGEgJl8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785093135; c=relaxed/simple;
	bh=1N8Q5nMLQeoEiC+bsBcNXEg7XdRHCXPbQUvVFIKePPo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C16J57tjMHYc9/XTqcerIy7RV6EwpvdXEuAvL29GKd1iBfLyDPD5Cl3lUgZ0NIwJ3UAwK1DJfygPfsx65q8SWSaNFdwUM2rFIxsYVeBfgOBfv2RznMsvDZ4kM2vx2TPQuQAilRKSfbx1RVm9sih7MS8DCDgiciAceRlazokUJ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpC1YCLn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpC1YCLn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271CA1F00A3A;
	Sun, 26 Jul 2026 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785093132;
	bh=rMRZhKDRi2VCNYahbTpDxAxfrw3li3aT33SeaJ/F4S0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GpC1YCLnByZBdZg6fq8990G0APGFhg03QNTXZb8OSH4ZdVNNAU77SEBfyJz2lfbsw
	 lQpSW2l7jF7lkzUi3uI8rc7tGN3JRUh3DOdEwfJEk5njl31SutlHdRUxAPZEv7pmar
	 aqOY8j2p22TWTsb53LcJhQzHF/del0btb2WHy6rPWcdSn6XIeEb3tXqVbjliRbItrC
	 cIhyTmAivhE5izkgZrzj8MYuEjERwYgoMeeF5iy6fcmmk6bgCaXIC9gCBAjGNeZjpC
	 TNJw0yf7lHoDnCGeQGUEwZOA1nSW9Vhkl3cpwg5i4AU59HtXJ3gHbbxeFP5lanFXG9
	 lrl52l7Q1/U1Q==
Date: Sun, 26 Jul 2026 20:12:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v8 5/5] iio: ABI: Encourage differential voltage ABI
 usage
Message-ID: <20260726201209.7c400ebd@jic23-huawei>
In-Reply-To: <9f47e67f188a910c3e025255dcd1354ef2dc026a.1784835663.git.marcelo.schmitt@analog.com>
References: <cover.1784835663.git.marcelo.schmitt@analog.com>
	<9f47e67f188a910c3e025255dcd1354ef2dc026a.1784835663.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:53:35 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> So far, parts that could only do differential voltage measurements were
> only required to have a consistent labeling of their channels by complying
> either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
> came to the conclusion that the voltageY-voltageZ ABI is better suited for
> differential-only chips as it provides a simple indication to users that
> the channels measure the difference of two inputs.
> 
> Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
> for chips that do only differential voltage measurements.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> New patch in v8.
> 
> The updated ABI doc might not have gotten very clear, so I'm completely fine
> with any modifications to this patch. Also, since the documentation update is
> minimal, doesn't add any new ABI, and might be picked up through Jonathan's
> tree, I'm not CCing the documentaion mailing list.
> 
Looks fine to me.  

I looked through the rest of the series and other than the thing you've
suggested doing of dropping the slightly more complex part for now, looks
good to me.  Feel free to send a v9 whenever you have it ready.  This is
near enough merge I don't mind going a bit quicker than normal.

Jonathan

>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5cc2e82c4997..7446e07b9ab2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -162,10 +162,11 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) differential voltage measurement equivalent to
>  		channel Y - channel Z where these channel numbers apply to the
> -		physically equivalent inputs when non differential readings are
> -		separately available. In differential only parts, then all that
> -		is required is a consistent labeling.  Units after application
> -		of scale and offset are millivolts.
> +		physically equivalent inputs when non-differential readings are
> +		separately available. Even though differential-only parts had
> +		been merely required to have consistent channel labeling, this
> +		ABI is preferred over the non-differential one for those chips.
> +		Units after application of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
>  KernelVersion:	6.18

