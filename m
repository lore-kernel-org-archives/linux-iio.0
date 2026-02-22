Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC83382FC;
	Sun, 22 Feb 2026 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766915; cv=none; b=Qwk39MPLPUoav+dheejcehfYaJsnPVp6PdGUfiKbZLMa49fP49X5XW1pL8JOz7QyYPL0JxVhJ04cCe00JoWXjy9Dkjy0AqD7OxPSdIRHJ2D9pmkZjfW0jZQNgsaNNGR+lDOOec+J5ehhUCcXcVfyR2Uw3tLZ8tX/XiEYLXzkSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766915; c=relaxed/simple;
	bh=uwW3vVVhwJp7bD75hFNGPQlKDNix2vQrKdMbPukK0M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuYoDWpUW+Z/8DCb7hpfbgniY72EChd+rWGQ1DUf9H6DAMP29yL8L9JHB8f1+4Pr2zP1W/6Vw6nxefsm74GB1l+eMqB7WrLCQw2cP/uYFcHqNjdtuDmGr7ZFHIBd31qSQ3EzZViQHdOzZRgUNaGgLUU1a6mFqPp7b4QRc9+QtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNSl4zYu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNSl4zYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46F5C116D0;
	Sun, 22 Feb 2026 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771766914;
	bh=uwW3vVVhwJp7bD75hFNGPQlKDNix2vQrKdMbPukK0M0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KNSl4zYuEZLNYGPeMljneQWKWo6xz/TIQIM+aZlp8o7sAWzvD5vli8P2ucmuUqU5C
	 TrZ+Nzzh0B2YJjmasDQ81cQJsSR+z3XZvnDJ7Tl3HPFBwVC7LnP+zL/cgxzd/2SxXk
	 sK5yuoNZt1HapO3yU3jrr2FYx8Mfiie9QYdWVubBuz3XGn0l7ZQUUSMQ2fA2zkwgKe
	 MPC/A4YZmdUbqetSrILni6HVIWFgZtJTB9oSpoDk86Y7EymzKMLkE26cNS8g21h9VF
	 ESIHycSzs6Pwzj/0ZHCkXbR18f4c4f4HU1YqUkduItuQM4vwFPERZf8fhYGcKPfk9i
	 D/3EQexJSOXDA==
Date: Sun, 22 Feb 2026 13:28:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ricardo Ribalda Delgado <ribalda@kernel.org>
Cc: Pranav Kharche <pranavkharche7@gmail.com>, conor@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Fix typo in ti,dac7612.yaml
Message-ID: <20260222132827.3b477dff@jic23-huawei>
In-Reply-To: <CAPybu_24T+1e0C9Bw9GSv5ErmV4AZ-EZoEe5VZc8AZoCCJw8Aw@mail.gmail.com>
References: <20260218035549.17871-1-pranavkharche7@gmail.com>
	<CAPybu_24T+1e0C9Bw9GSv5ErmV4AZ-EZoEe5VZc8AZoCCJw8Aw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2026 08:57:29 +0100
Ricardo Ribalda Delgado <ribalda@kernel.org> wrote:

> On Wed, Feb 18, 2026 at 4:56=E2=80=AFAM Pranav Kharche <pranavkharche7@gm=
ail.com> wrote:
> >
> > Fix a typo in the description where "Is is" should be "It is".
> >
> > Signed-off-by: Pranav Kharche <pranavkharche7@gmail.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com> =20
> Acked-by: Ricardo Ribalda <ribalda@chromium.org>
Applied.

Thanks,

Jonathan
