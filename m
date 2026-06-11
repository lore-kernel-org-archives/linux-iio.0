Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F083C415C;
	Thu, 11 Jun 2026 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171212; cv=none; b=jDlBAONvZeVpGWf+bCgbckl6/DcRbvVBkV1jcBdLAimvv2VekDqE8Faa7Pbo76DUyB9HSIvFC7wrLvHNCFKk7ZA1QLsTfv1FsdDKkDO339ggoFSB/1f/BliJ7G95Xdgtq9XhXYs+C9WUZD9S8NKEazX4zi9oNsyua01VJtUjDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171212; c=relaxed/simple;
	bh=I4VmH0+1BXmSATJf7U+iirKBEva6M13WN4GM2OiZJQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPsHFZuAvluwfeh+12hMRzXf8A/3oI4b2PYXBJ2Lj+CdUhXzM5FXuxMu+qQCmXEWtYB06FlJsgy80weXt99F19TJVvWUlxSl0T3Yok2MUw2JQS+H7arzjn8ZSDow9EcAC9Y+T1vTjAJ3uAiAwzxd0VsCnfgf+TUozY8R9Z3dPZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxL3h/WO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxL3h/WO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF6B1F00893;
	Thu, 11 Jun 2026 09:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781171211;
	bh=vBYiXBO1QvYUd7c4JBwOim5r+ZRJLOFNagjEN0EMx/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FxL3h/WODKW1bLUrt5e0K5UpAIwk/+vKG+SBLwTi0ajO8ubbGUA2v6zMi4+LXQwm+
	 xZwwwQAfhLMsJIYMVDArjcAYsOtRaohH+Wb3gQM0/KQCs8a2DTFo8G6fOGGHMIQo3f
	 H2YEcSZWmxI8Ndjf76WKlywFtZJ2L1qabXDy2xk4cLRJheSa6bN2PQFanprH3VWh98
	 0xtGGPw4Z5jvly8DlaXCtmK6KXGkTC3dYc+F//pk0bZ+CI/LxexYzr7eFTv5Ev+4d1
	 8C3FCrN0uVKML08Vvbw2+N3aFL9lRrOoh1Ph5Fs/oP4RCfjI4nKWWLRROjNcwxAFBv
	 JTP74ABa5eLaw==
Date: Thu, 11 Jun 2026 10:46:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org (open
 list), linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: fix brackets and bracelets
Message-ID: <20260611104643.2a5ed6c2@jic23-huawei>
In-Reply-To: <20260611085620.127959-2-manuelebner@mailbox.org>
References: <20260611085620.127959-2-manuelebner@mailbox.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 10:56:21 +0200
Manuel Ebner <manuelebner@mailbox.org> wrote:

> Fix missing and needless brackets
> Fix missing bracelets
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> ---
>  Documentation/ABI/stable/sysfs-class-infiniband      | 4 ++--
>  Documentation/ABI/testing/sysfs-bus-iio              | 4 ++--
>  Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192   | 2 +-

Take a look at hos this stuff is routed into upstream.  Each 
subsystem 'owns' their own documentation.  So this needs splitting up
on a per subsystem basis.  I'll also note that you've only +CC IIO folk
so you aren't going to get much review on the rest!

A few comments inline.

>  Documentation/ABI/testing/sysfs-firmware-dmi-entries | 2 +-
>  Documentation/ABI/testing/sysfs-firmware-gsmi        | 2 +-
>  Documentation/ABI/testing/sysfs-uevent               | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentation/ABI/stable/sysfs-class-infiniband
> index 694f23a03a28..e48a0d2fb4e5 100644
> --- a/Documentation/ABI/stable/sysfs-class-infiniband
> +++ b/Documentation/ABI/stable/sysfs-class-infiniband
> @@ -157,8 +157,8 @@ Description:
>  		all VLs from this port. This may include packets with errors.
>  		This is 64 bit counter.
>  
> -		port_rcv_packets: (RO) Total number of packets (this may include
> -		packets containing Errors. This is 64 bit counter.
> +		port_rcv_packets: (RO) Total number of packets, this may include
> +		packets containing Errors. This is a 64 bit counter.
Comma doesn't feel like the right choice here.  Perhaps,

		port_rc_packets: (RO) Total number of packets. May include
		packets containing Errors. This is a 64 bit counter.

Or just add the closing bracket.

>  
>  		link_downed: (RO) Total number of times the Port Training state
>  		machine has failed the link error recovery process and downed
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index 28be1cabf112..108ea0abbdb6 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -16,7 +16,7 @@ Description:
>  		In bridge applications, such as strain gauges and load cells,
>  		the bridge itself consumes the majority of the current in the
>  		system. To minimize the current consumption of the system,
> -		the bridge can be disconnected (when it is not being used
> +		the bridge can be disconnected when it is not being used
>  		using the bridge_switch_en attribute.

I think intent would be better reflected here by adding the closing )
That last bit is kind of a 'by the way' rather than the dominant point of
the sentence.

>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw

> diff --git a/Documentation/ABI/testing/sysfs-firmware-gsmi b/Documentation/ABI/testing/sysfs-firmware-gsmi
> index 7a558354c1ee..88ca75d323d1 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-gsmi
> +++ b/Documentation/ABI/testing/sysfs-firmware-gsmi
> @@ -18,7 +18,7 @@ Description:
>  
>  		/sys/firmware/gsmi/vars:
>  
> -			This directory has the same layout (and
> +			This directory has the same layout and
>  			underlying implementation as /sys/firmware/efi/vars.
>  			See `Documentation/ABI/*/sysfs-firmware-efi-vars`
>  			for more information on how to interact with
I think I'd add the bracket after implementation as this file is about ABI
so that's less important than the rest of the sentence.



