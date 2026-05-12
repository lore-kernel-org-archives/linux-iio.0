Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37D03A985E;
	Tue, 12 May 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594936; cv=none; b=sWEKcRlrp8ZBI0wX461eTsQnhzqJ+oDytNPCfMnCFvUwG67826WguoDSWL+A2OBCW8ouaqV+FvBJwOf5fnpb9MZHYbiZ00LXPJc24gxv+0xCBLwNcGgq70Jnh/fC0ebY4I+cDGv1vNXsbjSpCdRDYmsj7B4bruacIZ6aYXkONxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594936; c=relaxed/simple;
	bh=QsyZ+jGDUdo8t+SlKtoH09azsiN5A9KyulAjlpufLOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jp/cgKx5ZFO6mm5FJhZyOnRLulb/9jZj1LETMbGKwxvXIYhH6OCK4+To+zFrcHzX0QUOmTrl2gqqmjHSCBWbo3JozxkwxsjCUPrwbMWMiiBxtxzMhoAjY/myNOSqVx9oLLvcdMa9M3QEZOZRGfijcUDG3dpRT64FWuM81bMwLdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNbu7yYr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNbu7yYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A5C2BCF6;
	Tue, 12 May 2026 14:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594935;
	bh=QsyZ+jGDUdo8t+SlKtoH09azsiN5A9KyulAjlpufLOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNbu7yYrsLW7QH2rujl0MiD4eVRhdZ9nDwZB7qYPKAKvKOvew2m5Rd440Tgabvehl
	 ZH3vYHLR0Puxn//GYFxz2kfhZqPXEyLzeY9rCQnGutKfOSVZU1mhorDWpCOLS1/8yP
	 8Ua4lkvKgkN78WKacarOvqOPQ2qkp0d6aOYq7XhkmsoIrMyC9NCxIV2o+9CjvBZchP
	 Jm5yJNmBsVlRTsMvBounv9jX93WHECTHU1y4nnxI/uBNdpyJX4tSSXLZPVpxPsEqCg
	 B3+VMt6eJWOXtii5VdkVpDQwJrVqDvmWpwO2tlfh4DpAl4bkGtFdBjItzWlJ16S5yq
	 GednzJJ912DfQ==
Date: Tue, 12 May 2026 15:08:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abinash Singh <abinashsinghlalotra@gmail.com>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Abinash Singh <abinashlalotra@gmail.com>
Subject: Re: [PATCH] staging: Documentation: dds: replace frequencyY with
 frequency
Message-ID: <20260512150846.76f896a7@jic23-huawei>
In-Reply-To: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
References: <20260511171255.9668-1-abinashsinghlalotra@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 22:42:55 +0530
Abinash Singh <abinashsinghlalotra@gmail.com> wrote:

> From: Abinash Singh <abinashlalotra@gmail.com>
> 
> The documented frequencyY attribute naming is implementation
> specific and differs from common IIO sysfs attribute
> conventions.
> 
> Replace the non-standard frequencyY attribute documentation with
> out_altvoltageX_frequency and document tuning word selection
> through out_altvoltageX_frequencysymbol
> 
> This makes the documented ABI naming consistent with standard
> IIO sysfs attribute conventions and clarifies how tuning word
> registers are selected and programmed.
> 

Hmm. So some history on why it was done like this (long time back
but I think I recall the basic argument).

Consider the programming you need to set up FSK on a channel and
the fact that someone is recieving the result.

When you set the symbol to program it that channel will begin
outputting the voltage. That means someone at the other end starts
decoding it.

Hence we normally expect to set a frequency 'before' changing the
symbol.  Hence the per symbol files.

There might be a valid way to set them up using your proposed
interface but I'm not currently understanding what it is.

We went through the same dance with the more complex DDS that
Rodrigo is working on. Take a look at the multichannel approach
he is using.  It may apply here - I'm not sure.


> 
> Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
> ---
> 
> The out_altvoltageX_frequencysymbol and
> out_altvoltageX_frequency_scale attributes can be added
> through extended channel attributes (.ext_info in channel_spec struct of IIO)
> 
> Feedback on this approach would be appreciated, and if
> there is some other way in your mind. I would like to 
> work on that.
> 
> I am also interested in working on the sysfs-bus-iio-dds
> documentation and the ad9834 driver. I recently bought an
> AD9833 IC for experimentation and testing.
> 
Excellent!

Thanks,

Jonathan

> Thanks
> 
>  .../iio/Documentation/sysfs-bus-iio-dds       | 31 ++++++++++---------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
> index ee8c509c6733..dfc6ae3964d1 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-dds
> @@ -1,33 +1,34 @@
>  
> -What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencyY
> +What:		/sys/bus/iio/devices/.../out_altvoltageX_frequency
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Stores frequency into tuning word Y.
> -		There will be more than one out_altvoltageX_frequencyY file,
> -		which allows for pin controlled FSK Frequency Shift Keying
> -		(out_altvoltageX_pincontrol_frequency_en is active) or the user
> -		can control the desired active tuning word by writing Y to the
> +		Stores frequency into active tuning word register.
> +		To select active tuning word register, the user
> +		must write the desired index to the
>  		out_altvoltageX_frequencysymbol file.
> +		For pin controlled FSK (Frequency Shift Keying),
> +		tuning word registers must be loaded by selecting
> +		each via out_altvoltageX_frequencysymbol before enabling
> +		out_altvoltageX_pincontrol_frequency_en.
>  
> -What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencyY_scale
> +What:		/sys/bus/iio/devices/.../out_altvoltageX_frequency_scale
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Scale to be applied to out_altvoltageX_frequencyY in order to
> -		obtain the desired value in Hz. If shared across all frequency
> -		registers Y is not present. It is also possible X is not present
> +		Scale to be applied to out_altvoltageX_frequency in order to
> +		obtain the desired value in Hz. It is also possible X is not present
>  		if shared across all channels.
>  
>  What:		/sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Specifies the active output frequency tuning word. The value
> -		corresponds to the Y in out_altvoltageX_frequencyY.
> -		To exit this mode the user can write
> -		out_altvoltageX_pincontrol_frequency_en or
> -		out_altvoltageX_out_enable file.
> +		Specifies the active output frequency tuning word index.
> +		Writing an index here selects which tuning word register
> +		is written by out_altvoltageX_frequency. To exit this mode
> +		the user can write out_altvoltageX_pincontrol_frequency_en
> +		or out_altvoltageX_out_enable file.
>  
>  What:		/sys/bus/iio/devices/.../out_altvoltageX_phaseY
>  KernelVersion:	2.6.37

