Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157525;
	b=ZIFFYCSraEKJ6qBPWR0BukNrPRIicIg8bgeVTkz/KcESG8oGOpQ18SU2u4GxLV7VkEm0
	 Cu8fEcJFDw/aQe9kGqDcH/o3NpfKr+pj3Fa+oMtfI9YGOHv1BkQQb0n+BgfQ8rEfnB+A9
	 nJA1GdTE047jWA/gC5yP9ltdKl+YaoK3GF82oObSYV5y7j6x1ZMiDIHlh6m5+quuDuPyC
	 Jd0BUM1vlegMUVjhMYfzPOSjlhMBXwNFmc5r/Q+w4yQ+MTIFMf/tHQEEoeGsNQai5WbBq
	 tWh4Hx7FpYZR36j8pKSNmCDjNic19qKwMIL7keQM0puNHaUkaUPh3i9UDCxmR8mPE1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157525;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0yRzutRdG3ui1l9nm3eCsz3wlEwTD8dCkFjiiMx3rLE=;
	b=0U8GZnG6uHeRF1uFOQMQvq4ny5eoYrLTach7PTmu5gSMzqMeWLDE+y3u/zcLIZX+MJo0
	 Kr+n2m4UNw4xS0rH/+YPI2AfT8t9LKvQRzYf3nwk6pDn19GiXRvPEnOu+i0ONN9f/UWC2
	 rOsyla/C9kHEZwfj3wsQtE5wjfejLf7UrXxrjZ6A0oXdfCL5lpZqUOqkw1C353Ixj1C6B
	 wCHVwF57ES33wpZtXrMtA2Kuqpz9/fbqBeCtLDbha5gcMAUQxL8L8P9NQf70G1Zr3oSrr
	 c/74qsuP1H6G3Y7fhvRK8QPLdWR0bC0NuMX9ErfBJ57FbQ+ntHEIloWXXwUktEyOFAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS0J2LXS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC6606A31A;
	Wed, 28 Oct 2026 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS0J2LXS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E861D1F01825;
	Wed, 28 Oct 2026 03:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157525;
	bh=0yRzutRdG3ui1l9nm3eCsz3wlEwTD8dCkFjiiMx3rLE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fS0J2LXShzRXImGzjFcnR0OE0DW0HQ6xp8hYJPlJXja1o4iKrHYrqq8XYGfL/FgQC
	 jmRcYwKu/RHbF7kve5zOTB73ZoT6rSep3vps1xwYvK+2Fpzxhv3UUX+UPHl9PadEd0
	 Sac61LnaTMGHD3n8OqDqCqs+c+uHT19RuZk/SEyGL7PPu54SCMAzrreyL6ew/9adxx
	 EeG7Tak4ucY+H6UXxMqkgpfWh6ugrGrQBbjhQq8/HrxyEANQefBNWmDuwYnuJ2dilf
	 BZw/XIpnRhSLF6z3QxVDkLiM1AI9/5elrI6sFXeF4XYuOV0Wb64pzXoDQ4J5IMgKz2
	 C2FpFaAUAEsvg==
Date: Wed, 28 Oct 2026 03:18:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, Benson Leung <bleung@chromium.org>, David Lechner
 <dlechner@baylibre.com>, Guenter Roeck <groeck@chromium.org>, Jagath Jog J
 <jagathjog1996@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jinseob Kim <kimjinseob88@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Remi Buisson
 <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, Bart Van
 Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 2/9] iio: core: annotate the conditional mode claims
Message-ID: <20261028031834.2ff7e6bf@jic23-hlaptop>
In-Reply-To: <20261027124954.110697-3-zoone.rupert@gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
	<20261027124954.110697-3-zoone.rupert@gmail.com>
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

On Tue, 27 Oct 2026 14:49:47 +0200
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> iio_device_claim_direct() and iio_device_try_claim_buffer_mode() hold
> the mode lock only when they return true, but carry no annotation. With
> context analysis on, each caller that releases the claim is reported
> for releasing a lock it never took.
> 
> Mark both __cond_acquires(true, indio_dev), the token that
> __iio_dev_mode_lock() acquires. Sparse no longer reads these
> annotations, so drop the comment about it.
Hi Rupesh,

The history of the definitions of these being in the header at
all was to make them visible enough to sparse that it could
figure out the locking and 'mostly' give good coverage.

Given that's no longer necessary, maybe it makes sense to make
the implementations private. It doesn't really help us that
much as those nasty helpers are still needed for the
rarely used guard that claims the current mode.

So maybe it's worth this maybe not...  Anyhow, perhaps one for
another day given I don't think it helps this effort.

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e9a5d1d905c1..04c194bdda87 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2269,6 +2269,33 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(__iio_dev_mode_unlock);
 
+bool iio_device_claim_direct(struct iio_dev *indio_dev)
+{
+       __iio_dev_mode_lock(indio_dev);
+
+       if (iio_buffer_enabled(indio_dev)) {
+               __iio_dev_mode_unlock(indio_dev);
+               return false;
+       }
+
+       return true;
+}
+EXPORT_SYMBOL_GPL(iio_device_claim_direct);
+
+bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
+       __cond_acquires(true, indio_dev)
+{
+       __iio_dev_mode_lock(indio_dev);
+
+       if (!iio_buffer_enabled(indio_dev)) {
+               __iio_dev_mode_unlock(indio_dev);
+               return false;
+       }
+
+       return true;
+}
+EXPORT_SYMBOL_GPL(iio_device_try_claim_buffer_mode);
+
 /**
  * iio_device_get_current_mode() - helper function providing read-only access to
  *                                the opaque @currentmode variable
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ca91f5a64626..b9e4888e18bc 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -718,18 +718,7 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
  *
  * Returns: true on success, false on failure.
  */
-static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
-       __cond_acquires(true, indio_dev)
-{
-       __iio_dev_mode_lock(indio_dev);
-
-       if (iio_buffer_enabled(indio_dev)) {
-               __iio_dev_mode_unlock(indio_dev);
-               return false;
-       }
-
-       return true;
-}
+bool iio_device_claim_direct(struct iio_dev *indio_dev) __cond_acquires(true, indio_dev);
 
 /**
  * iio_device_release_direct() - Releases claim on direct mode
@@ -753,18 +742,8 @@ static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
  *
  * Returns: true on success, false on failure.
  */
-static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
-       __cond_acquires(true, indio_dev)
-{
-       __iio_dev_mode_lock(indio_dev);
-
-       if (!iio_buffer_enabled(indio_dev)) {
-               __iio_dev_mode_unlock(indio_dev);
-               return false;
-       }
-
-       return true;
-}
+bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
+  __cond_acquires(true, indio_dev);
 
 /**
  * iio_device_release_buffer_mode() - releases claim on buffer mode


> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> 
>  include/linux/iio/iio.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 9b63785d5aec..ca91f5a64626 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -707,13 +707,6 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  void __iio_dev_mode_lock(struct iio_dev *indio_dev) __acquires(indio_dev);
>  void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
>  
> -/*
> - * Helper functions that allow claim and release of direct mode
> - * in a fashion that doesn't generate many false positives from sparse.
> - * Note this must remain static inline in the header so that sparse
> - * can see the __acquires() and __releases() annotations.
> - */
> -
>  /**
>   * iio_device_claim_direct() - Keep device in direct mode
>   * @indio_dev:	the iio_dev associated with the device
> @@ -726,6 +719,7 @@ void __iio_dev_mode_unlock(struct iio_dev *indio_dev) __releases(indio_dev);
>   * Returns: true on success, false on failure.
>   */
>  static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
> +	__cond_acquires(true, indio_dev)
>  {
>  	__iio_dev_mode_lock(indio_dev);
>  
> @@ -760,6 +754,7 @@ static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
>   * Returns: true on success, false on failure.
>   */
>  static inline bool iio_device_try_claim_buffer_mode(struct iio_dev *indio_dev)
> +	__cond_acquires(true, indio_dev)
>  {
>  	__iio_dev_mode_lock(indio_dev);
>  

