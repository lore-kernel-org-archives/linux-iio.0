Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863591;
	b=SOHvt4Kja7RfMuVxU5a9lFUfHRLm5k2mavzgiXA3JbztEVvs+RSPYCfGzpGKRIZWCh6s
	 jTxqmHCB4+sNJFY0dzpycIem4EzIQIU8Tzc67nCxqkFarLCjO4vaSzz1LM1z78ElGHC2B
	 0uBRpt6W1kkryub78g8iAttLtquKkOFjHXlrc/0LhgsmbavysxLQBl8Nkjlv7EjimB1aV
	 ub3mW0n48SlTuQXduvKDvUdoMbwbrG5gL9k3T3cMGCHOfnnJMmDBDAnBQi/RL1LXgigfZ
	 8mnN1yKkxqCoFB6t8eYKA9IXUc5AinW1VMA9l+y6oACtQ6kJXOZpCYbcRaSnmloiF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863591;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=Kijzy9EdMhpT7YhrRfRAvZoCaEVnAEPrNMBnKqo82nY=;
	b=AtX1G4LLbHXWZjZ/5R7UBei8IUNfFwfDzBrJZYGj9HSblM36HWSiI3Y4rhPwI6yZfl2u
	 /ru0GiLISor4xGpo4k06Wg6SjKXSZ9oodLz9dXcBtEecD9UCUUG9QXRUvZtvkIWh+/zA1
	 pSBspDP+2NjnPrOIah2MzUBeVZjiY79SOq2XBwhcRyc8UolmhGtRKvqYx2u3MNsce3XhH
	 W+sXv9IUc8QyQSDixZD5+opwef5iodBzhNcZHr+dJLwSboCYFXN/dqyUWQ1TiqnZRS4Y6
	 7SMIbUVWtZfEPIHNE10RA7NMmIVd7pzwI4q55iMmAolMt7tgui9rZfvF513JYqSJdOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PZARaFnR;
	arc=none smtp.remote-ip=95.215.58.108
Received: from mta1.migadu.com (out-108.mta1.migadu.com [95.215.58.108])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C7606A31A
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 17:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PZARaFnR
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZfEMLtaMNfEqeXSdp7dnPs3+qMD4QqvgJKLt9hUIpWQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792863588; v=1; x=1793468388;
 b=PZARaFnREmGjoUbKSjZ1tyTHw9KlCcTo9q11SHFQ5YuA3LhEkwPY1+6RaA1hx3KjiKtS8in+
 X+2xcSTg4npo5N3HCKteRdiJss8lslX/LTL05pidb0zDQKtqLUdxNbMTPAW9MNWTGbvMe5u11u/
 0t8Gg/o2pS2s4HHFGyHO67PE=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bd748e8ee187c88c;
	Sat, 24 Oct 2026 17:39:48 +0000
X-Mizu-Trace-ID: bd748e8ee187c88c
X-Migadu-Flow: FLOW_OUT
From: Igor Korotin <igor.korotin@linux.dev>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>,
 Brandon StJohn <branstj@gmail.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Sat, 24 Oct 2026 18:39:46 +0100
Message-ID: <179286358623.55649.5397316745104390556@linux.dev>
In-Reply-To:
 <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
References: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
 <179260197668.3127.18219777718091081046@linux.dev>
 <CAO26r3QK+Q5=JR5TeMzEX-WiLpgYWd8Zn0O1qx11LxTgN96BPg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Coirul,

Here's the full diff, applied on top of your v6 patches 3 and 4.

diff --git a/drivers/iio/position/as5600.rs b/drivers/iio/position/as5600.rs
index b72775241e81..f2897fbf8aa2 100644
--- a/drivers/iio/position/as5600.rs
+++ b/drivers/iio/position/as5600.rs
@@ -36,7 +36,8 @@
         Device,
         IioChanInfo,
         IioDriver,
-        IioVal, //
+        IioVal,
+        Registered, //
     },
     io::Io,
     module_i2c_driver,
@@ -65,14 +66,12 @@

 i2c_device_table!(
     I2C_TABLE,
-    MODULE_I2C_TABLE,
     <As5600 as Driver>::IdInfo,
     [(DeviceId::new(c"as5600"), ())]
 );

 of_device_table!(
     OF_TABLE,
-    MODULE_OF_TABLE,
     <As5600 as Driver>::IdInfo,
     [(of::DeviceId::new(c"ams,as5600"), ())]
 );
@@ -97,25 +96,29 @@ unsafe impl Sync for As5600Channels {}
 });

 #[pin_data]
-struct As5600Priv {
+struct As5600Priv<'a> {
+    client: &'a I2cClient<Bound>,
     #[pin]
     io_lock: Mutex<()>,
 }

+// SAFETY: `I2cClient<Bound>` methods go through kernel I2C core functions
+// that provide their own synchronization (bus locking); no `&self` method
+// exposes interior mutability. The borrowed `client` field can therefore be
+// safely accessed and shared across threads like the rest of `As5600Priv`.
+unsafe impl Send for As5600Priv<'_> {}
+// SAFETY: See above.
+unsafe impl Sync for As5600Priv<'_> {}
+
 // SAFETY: AS5600_CHANNELS contains one valid, immutable IIO_ANGL channel
 // exposing only RAW and SCALE. It has no event or extension callbacks,
 // and all optional pointer fields are null.
-unsafe impl IioDriver for As5600Priv {
-    fn read_raw(
-        &self,
-        parent: &kernel::device::Device<Bound>,
-        _chan: *const iio_chan_spec,
-        info: IioChanInfo,
-    ) -> Result<IioVal> {
+unsafe impl IioDriver for As5600Priv<'_> {
+    fn read_raw(&self, _chan: *const iio_chan_spec, info: IioChanInfo) -> Re=
sult<IioVal> {
         match info {
             IioChanInfo::Raw =3D> {
                 let _guard =3D self.io_lock.lock();
-                let client: &I2cClient<Bound> =3D parent.try_into()?;
+                let client =3D self.client;

                 let io =3D client.smbus_io();
                 // Read status register to verify magnet presence before
@@ -142,14 +145,17 @@ fn channels(&self) -> &'static [iio_chan_spec] {
     }
 }

+struct As5600;
+
 #[pin_data]
-struct As5600 {
-    _registration: (),
+struct As5600Data<'bound> {
+    #[pin]
+    _iio_dev: Device<As5600Priv<'bound>, Registered>,
 }

 impl Driver for As5600 {
     type IdInfo =3D ();
-    type Data<'bound> =3D As5600;
+    type Data<'bound> =3D As5600Data<'bound>;

     const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> =3D Some(&I2C_TABLE);
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D Some(&OF_TABLE);
@@ -162,15 +168,22 @@ fn probe<'bound>(
         dev: &'bound I2cClient<Core<'_>>,
         _id_info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        try_pin_init!(As5600 {
-            _registration: {
+        try_pin_init!(As5600Data {
+            _iio_dev: {
+                // Deref coercion: I2cClient<Core<'_>> -> I2cClient<Bound>.
+                let client: &'bound I2cClient<Bound> =3D dev;
+
                 let priv_init =3D pin_init!(As5600Priv {
+                    client,
                     io_lock <- new_mutex!(()),
                 });

-                Device::build_device(dev.as_ref(), c"as5600", INDIO_DIRECT_M=
ODE, priv_init)?
-                    .register(&crate::THIS_MODULE)?;
+                let unregistered =3D
+                    Device::build_device(dev.as_ref(), c"as5600", INDIO_DIRE=
CT_MODE, priv_init)?;
+                let registered =3D
+                    unregistered.register(kernel::module::this_module::<crat=
e::LocalModule>())?;
                 dev_dbg!(dev.as_ref(), "AS5600 magnetic position sensor read=
y\n");
+                registered
             }
         })
     }
diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
index 9ad2f50948de..4648424c7600 100644
--- a/rust/kernel/iio.rs
+++ b/rust/kernel/iio.rs
@@ -21,7 +21,6 @@
         self,
         Bound, //
     },
-    devres,
     error::{
         code::*,
         to_result,
@@ -159,15 +158,12 @@ pub enum IioVal {
 pub unsafe trait IioDriver: Send + Sync {
     /// Called by the IIO core to read channel information.
     ///
-    /// `parent` is the parent device supplied to [`Device::build_device`].
     /// `chan` identifies the channel, and `info` selects the requested
-    /// information, such as its raw value or scale.
-    fn read_raw(
-        &self,
-        parent: &device::Device<Bound>,
-        chan: *const iio_chan_spec,
-        info: IioChanInfo,
-    ) -> Result<IioVal>;
+    /// information, such as its raw value or scale. Implementors must
+    /// capture whatever bus-specific resources they need at registration
+    /// time (see [`Device::build_device`]) rather than re-deriving them
+    /// from a generic parent reference here.
+    fn read_raw(&self, chan: *const iio_chan_spec, info: IioChanInfo) -> Res=
ult<IioVal>;

     /// Returns the channel specifications for this driver.
     ///
@@ -204,16 +200,6 @@ fn channels(&self) -> &'static [iio_chan_spec] {
     // initialized `T` that remains valid for the duration of this callback.
     let driver =3D unsafe { &*priv_ptr };

-    // SAFETY: `indio_dev` is valid by the callback contract. Its parent
-    // was supplied as a bound device to `build_device`.
-    //
-    // During registration, the builder holds that bound parent borrow.
-    // After ownership is transferred, parent devres runs the registered
-    // device's destructor, which unregisters the IIO device and drains
-    // the supported read_raw paths before destroying the private data.
-    // The parent therefore remains bound throughout this callback.
-    let parent =3D unsafe { device::Device::<Bound>::from_raw((*indio_dev).d=
ev.parent) };
-
     // `info` is `long` from C. Negative values and values > u32::MAX
     // are unsupported iio_chan_info variants; both map to EINVAL.
     let info_enum =3D match u32::try_from(info)
@@ -224,7 +210,7 @@ fn channels(&self) -> &'static [iio_chan_spec] {
         None =3D> return EINVAL.to_errno(),
     };

-    match driver.read_raw(parent, chan, info_enum) {
+    match driver.read_raw(chan, info_enum) {
         Ok(IioVal::Int(v)) =3D> {
             // SAFETY: `val` is valid per the function's Safety contract abo=
ve.
             // `val2` is not written; `IIO_VAL_INT` signals to the IIO core
@@ -271,11 +257,8 @@ fn channels(&self) -> &'static [iio_chan_spec] {
 pub struct Registered;

 /// An initialized IIO device awaiting registration.
-///
-/// The parent remains bound until this builder is consumed or dropped.
-pub struct UnregisteredDevice<'a, T: IioDriver> {
+pub struct UnregisteredDevice<T: IioDriver> {
     device: Device<T>,
-    parent: &'a device::Device<Bound>,
 }

 /// An owned IIO device with in-place initialized driver data.
@@ -363,12 +346,12 @@ impl<T: IioDriver> Device<T> {
     /// Allocation and initialization errors are propagated.
     ///
     /// Call [`UnregisteredDevice::register`] to register the device.
-    pub fn build_device<'a, E>(
-        parent: &'a device::Device<Bound>,
+    pub fn build_device<E>(
+        parent: &device::Device<Bound>,
         name: &'static CStr,
         modes: u32,
         init: impl PinInit<T, E>,
-    ) -> Result<UnregisteredDevice<'a, T>>
+    ) -> Result<UnregisteredDevice<T>>
     where
         Error: From<E>,
     {
@@ -406,7 +389,7 @@ pub fn build_device<'a, E>(
         // large enough for `T`. The private data remains at a fixed address=
 in
         // the separate IIO allocation until it is dropped. On initialization
         // failure, the error path only frees the allocation.
-        let init_result =3D unsafe { init.__pinned_init(priv_ptr) };
+        let init_result =3D unsafe { pin_init::raw_try_init(priv_ptr, init) =
};
         if let Err(e) =3D init_result {
             // SAFETY: `pin_init` guarantees partial-init rollback internall=
y.
             // `priv_` memory was not fully initialized, so we only free the
@@ -446,21 +429,23 @@ pub fn build_device<'a, E>(
             (*indio_dev).modes =3D modes;
         }

-        Ok(UnregisteredDevice { device, parent })
+        Ok(UnregisteredDevice { device })
     }
 }

-impl<T: IioDriver + 'static> UnregisteredDevice<'_, T> {
-    /// Registers the IIO device and transfers ownership to parent devres.
+impl<T: IioDriver> UnregisteredDevice<T> {
+    /// Registers the IIO device.
     ///
-    /// Parent resource teardown unregisters the device and completes its
-    /// supported `read_raw` callbacks before destroying the private data.
+    /// The caller owns the returned, pinned [`Device<T, Registered>`] and is
+    /// responsible for keeping it alive for as long as the registration
+    /// should remain visible to userspace; dropping it unregisters the
+    /// device and tears down the private data.
     ///
     /// On failure, the device is released and any successful registration is
     /// undone.
     #[inline]
-    pub fn register(self, module: &'static ThisModule) -> Result {
-        let Self { device, parent } =3D self;
+    pub fn register(self, module: &'static ThisModule) -> Result<Device<T, R=
egistered>> {
+        let Self { device } =3D self;

         // SAFETY: `device.indio_dev` is a valid, fully-initialized `iio_dev`
         // allocated by `iio_device_alloc` with its name, info vtable, chann=
els,
@@ -475,6 +460,6 @@ pub fn register(self, module: &'static ThisModule) -> Res=
ult {
         };
         forget(device);

-        devres::register(parent, registered, GFP_KERNEL)
+        Ok(registered)
     }
 }

Cheers
Igor
