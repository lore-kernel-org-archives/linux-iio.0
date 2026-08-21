Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA17F30E821;
	Fri, 21 Aug 2026 16:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328178; cv=none; b=MhMUyGXJ64jgRco1HBDF1J82Qz3s6mT3PA6kFACsKXBdJMU/vgn7EKZYjoITYLeoJ6hs6WVP9FmfYCi7Trk85hUjmqnaVPec33LJgAwL08CWZSpV86dNmBJGTWlHcrWhTcvI6bAj2NfAY7c+hx84Dt4LEg9+LCIdy3TGvgTsXhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328178; c=relaxed/simple;
	bh=jlmx18BUGtZujBHG8gk3ywP6LfzwlTBnBXdqoqh3g64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnuxsKAO9V1ZBYOtJG8XWLZQnJMgEP5Jvd20hGO+lu1oSzZRDvGO7lmELJ79w38Jf05s7Z1rAKL3tKwp6dGCsFNc2nfa5VXjuWzlo8EA7n1tqxuwqcsbe4+gVCeqBgEJgFp4Vtd3O882Yr3FcOzGyKAgeD2DlcszoLYXzWpJdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNwCldJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNwCldJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6401F000E9;
	Fri, 21 Aug 2026 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787328177;
	bh=bjG2PgPYQ0d3EKYtGfsk5xwSrorEI6krhBASrKtsTLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SNwCldJztOxqdrNY5RSdUE2TQhaJ1o8bHGKF5LzEG7TSzc+8wq/Z1nW0cozKEErFO
	 rPsw6NtjzKelcpnsfx/F8GgqFjX+Qs+9i4BJqczhK0snnYKn02RsaRQFANrj+W3QK8
	 /G3REZJpSUoI/iA8RHEjHvNAm3Ap+E+ixIwqfxga0PDggGsqGhfMAbu2jgb0uTy3P4
	 8KfbQnCc1i/yhO0qS9uJcaIP10FA0e5+9so2ADIzAgVBr7iOHvueiDJvv4+XxbvMSg
	 rx5dbPQg6C1b8fCsuDmZS7ZSfDu7Fu/Y3RG2GGuiDVGiw751BX44xzVqd/THXkfb6u
	 8p+PAf1dLT9XA==
Date: Fri, 21 Aug 2026 17:02:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
 dlechner@baylibre.com, groeck@chromium.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <20260821170251.1e241047@jic23-huawei>
In-Reply-To: <20260821021007.30946-1-triet.hoang@datalogic.com>
References: <20260821025453.5944eb9d@jic23-huawei>
	<20260821021007.30946-1-triet.hoang@datalogic.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 09:10:07 +0700
Triet Hoang <triet.hoang.dev@gmail.com> wrote:

> On Fri, 21 Aug 2026 02:54:53 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > Hi Triet,
> > 
> > Wrap to 75 ish chars for commit messages.  
> 
> Thanks for that! I will keep in my mind.
> 
> > > Take a look at where this macro and the comment right next to it...  
> >   
> > >  EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);  
> > relating to this circumstance.  
> 
> I think we should use EXPORT_GPL_SIMPLE_DEV_PM_OPS here.
> Should I send the v2 patch to correct it?
Please do.  Though normal process is to wait a few more days
first to see if you get any other feedback that can be incorporated
into v2.

Jonathan

> 
> Regards,
> Triet

