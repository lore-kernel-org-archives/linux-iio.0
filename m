Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704617;
	b=ie8+WJrvGNNH5e9t1m6YsCeeoju4fEkpOz0L35Fu0R4hjNiPWTJFiG1zCq197T9Jwbnu
	 8tbYaZO2LKTf0/6o9L525n4dfcK6sXX4yEK5ChAul8pTS8ORxd9a1XUL/G4KUE14Bbykm
	 1QnI+tOOz8EiTTTA8PWYDQop5vvQJAyhTf9jQz9jSzCY7CruziT7QR2TGLK72VTa/aFgP
	 PWNESSMFB1OiC78wGLw2fiLgk22Dn3GPIT0qEFsomXrnggVvGPhj1gGOqEB82fiYAeILa
	 5eQu7HFXdaNIVF2IIyVSV/krcIuvGybyjGmBuhYsja6uFJ6ZKPKW6+3Qhgazm/XKUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704617;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=azdkMwcps7Uxh2CJ3w5mNX0OF+3zqka0dgJ8u/srPjo=;
	b=c7G3Y6TmeL9nZyWCEhhFrXAV4sqJllBSvBozh3+0Cbw1yCxq1CukKmM/dj7HBvfCf6Nx
	 hiLGwAEMV9sXx6KqtCbtkkxbS5gP4kSL9VLQyFSKCv2CD5IeixLPNU6V3v/2zN1it4MMv
	 EEjLgrZSfVdFirvQVQf3EhuycldPt0dpVCieq23Wm8dlQbNVOSrPt9P/cfZLocWMAJJH+
	 bEEXXJW4wxJA0fvLerSeexwVPL7yznNDzL+8OslSPc4VLdPRR7+S3PsA4JExdLDs/t3ru
	 Tx3Fz9m22c449LUUuI07SRciFoGqvWJUle0pidkuJndV5kM+/uEWCkn2fcFqOzDmZFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjSQY4gQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AB606A327;
	Sun, 15 Nov 2026 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjSQY4gQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD181F000C5;
	Sun, 15 Nov 2026 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704617;
	bh=azdkMwcps7Uxh2CJ3w5mNX0OF+3zqka0dgJ8u/srPjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mjSQY4gQkTpvEXrE8ZSHkGMQXWjKSl68TQyTy3HY6L+vJYzgVQzwnWpLP+K2Opu/f
	 KuSU7UugCPhbS9XYSiW7G2tUrWWJ9WUpgDy/fvuVqjQO28OHsb8rL1rgn4N6LKsp/U
	 h0wPW+4ws6gHR0zCwp2pyIYVIq//ZPzrI0pvJDz6J02A8IYIK+4MEPiJNrY3zqg/j8
	 hPkMF9n7LP7ThEEQswzOD//lmZZF0bnjN/oGfUGFRMfMRgOPYXKUf36uQFkKZNMp3H
	 z2GjBaZWNhEVmCOEjPmrpOx7yBUEH9nuY8qiDocAZ8NNWU9i2q6atR0TN7siL+awTH
	 3m+6fx4Hp/BzQ==
Date: Sun, 15 Nov 2026 01:03:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: <sai.krishna.potthuri@amd.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
 <pramod.nexgen@gmail.com>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH v6] dt-bindings: iio: adc: Convert xilinx-xadc bindings
 to YAML schema
Message-ID: <20261115010328.74732486@jic23-hlaptop>
In-Reply-To: <20261114054826.3222636-1-dileepkumar.nagavarapu@amd.com>
References: <20261114054826.3222636-1-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 11:18:26 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> From: Pramod Maurya <pramod.nexgen@gmail.com>
> 
> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
> from the legacy plain-text format to a YAML.
> 
> The new binding covers the same hardware and compatible strings:
>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardblock)
>   - xlnx,axi-xadc-1.00.a  (AXI softblock)
>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
> 
> The xlnx,channels subnode retains its legacy name (including the comma)
> for backwards compatibility with existing device trees. The reg property
> of the channel subnodes is limited to the valid channel range of 0 to 16.
> 
> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
> Co-developed-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Applied to the testing branch of iio.git.

Thanks,

Jonathan
