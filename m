Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1463E6DDD
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830509; cv=none; b=PqUbwL02ze4M4RHt+9gNuHEv6XcNstOOZVzsYPFfmq1liwQIKhZQ7+gm/AM4YByjX4/ho4tG07FQZkcPJHkkUwGnJ5tSTYwnM4nNmnojcdgoC02YS9yg+kmrkMRWTwoUzoDop19xdTe7ZYcfrDsmszp0fdUWnWmZ33EHJDQwhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830509; c=relaxed/simple;
	bh=5AJDJF1jtlINEN96xVSJuQrVxzzJOTcr94RJUDObE/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTb0cWagEL7l08iWZzkCjxo2qSbWC/il/hfMZI0FpzcoRqjUX+0lcig3zG1ao26Q5kbPX+MA6KIrdBU/Mvy9c8ZMOJZVZoultul3WDNX/a2ihI03ZsppzEp3zzkRYvqTUZKCRNymj514KCutIGcFGBXElmuBYTq5AW6zouAUEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2PrnMgH8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2PrnMgH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6738CC2BCB0;
	Fri, 15 May 2026 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778830508;
	bh=5AJDJF1jtlINEN96xVSJuQrVxzzJOTcr94RJUDObE/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2PrnMgH8jmvVAsma5J1hBlSJTnCtChjFQFL2csUJOZ/CddUwRw6ihmUfF7VQEy+25
	 XNsaZTfl+TF/NujH2P1MJ7H/6rD6Soat6Y63HE/BNJVATFXhKW0UV0/gkr9QOfnU/U
	 JDDu0VuHfDxKH5QEviCPC2m/giVZ3jSF/CIOPmrQ=
Date: Fri, 15 May 2026 09:35:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 7.1
Message-ID: <2026051506-bring-tamper-5246@gregkh>
References: <20260515061519.339714-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515061519.339714-1-wbg@kernel.org>

On Fri, May 15, 2026 at 03:15:17PM +0900, William Breathitt Gray wrote:
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.1

Pulled and pushed out, thanks.

greg k-h
