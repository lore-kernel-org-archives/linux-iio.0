Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF030567F;
	Sun, 23 Aug 2026 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787528472; cv=none; b=BNf2zViKHsGOJENLFMX0y1g2ywEtPYKZwufAynA42/ry16DmJp6cDToB6u3YnjLQsZ7OldsB9jHil/Aa615eGvydDV5j07naOPRNmVrpg0PoJgQ+EEjyKXrmfzQ1dxGq1tNdZEIKn39ziUlO+OpXEvXS9sDHo7Znq2sX1inBZ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787528472; c=relaxed/simple;
	bh=naEry9hHJs/3jKGdB0Cl3+Qq6kgq3fxBElDuB0CNUN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRjdNKJoqkLVyOZ58gtqZltvOfY5BEjFfphRX4ZYCU/l8Qox/GrPKpAafBbDDzlhUc0eq+yt/FWEJUVRMMA13ZY9RqWP2O0FclFngCEDcYFGlU9MazfEIgYAAUNFVzrZ74st/dPktZ6I2eLAzflfBNmNMUBC3/BWTNaYWsEAoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgLvRBZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgLvRBZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9156D1F000E9;
	Sun, 23 Aug 2026 23:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787528469;
	bh=Jt1P7futTLMh4f/BdOe0hzzo2YjnU8JmZiVagbmermA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cgLvRBZzOoLIDzALoK/zUOBIJSIKA3VDT/0Wt2oguldhRI6CYKmq0Q6TqeXX2sb1v
	 h1VQB0+i8v4JmvKDr5p1lDKDf7iUjqahvx9T3vVuJrIDnmb3huQhOsWd8hqN0OgqUO
	 3sDMX/06BfwQKtb07pLaAT7Ey7Imxh3tzIBRiv5KvGHVYTulqTkIL+cSYzmRGJLELI
	 02aoDZpfBt7aenCwc2/TKvemntKzstWV6oRG3uc1rnx9t0JGhha7xXeFxjqdysAiAq
	 lGt551Jz/F1kmIKxaqrOxuJmZUgrukyu/HZzChHNsBVLA4lSCAXHqrE9RYVj+LMA5o
	 Zxr4FvgsWBAIg==
Date: Mon, 24 Aug 2026 00:41:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>, Mark Brown
 <broonie@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andi.shyti@kernel.org,
 wsa+renesas@sang-engineering.com, ojeda@kernel.org, dakr@kernel.org,
 igor.korotin@linux.dev, branstj@gmail.com, brucer42@gmail.com
Subject: Re: [RFC PATCH v5 1/3] i2c: rust: implement SMBus access via
 IoBackend and FallibleIoCapable
Message-ID: <20260824004103.54eb2f7b@jic23-huawei>
In-Reply-To: <20260822062725.60519-2-muchamadcoirulanwar@gmail.com>
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
	<20260822062725.60519-2-muchamadcoirulanwar@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Aug 2026 14:26:56 +0800
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> Implement SMBus byte and word read/write operations for I2cClient using
> the FallibleIoCapable trait from the generic I/O backend infrastructure.
>=20
> I2cClient now exposes an I2cBackend that implements FallibleIoCapable<u8>
> and FallibleIoCapable<u16>, replacing the previous IoCapable approach.
> I2C/SMBus bus transactions are inherently fallible (NACK, arbitration
> loss, timeout), so the infallible IoCapable is not appropriate here.
> FallibleIoCapable carries the errno from i2c_smbus_read_byte_data and
> i2c_smbus_read_word_data directly to the caller via Result<T>.
>=20
> The implementation is restricted to I2cClient<Bound> as I/O operations
> require a live device context.
>=20
> I2cClient<Bound>::smbus_io() returns an I2cView handle for use with the
> generic try_read8/try_read16 methods. Two standalone methods are also
> provided for odd-offset word access that bypasses the alignment check
> in the Io trait:

Given some devices implement auto address increment and others decrement
even in aligned byte pairs it seems you will see things that 'smell' like
they are unaligned.

I'd forgotten this fun corner of smbus like i2c devices!

>=20
>   smbus_read_word()        - CPU-native byte order (SMBus LE wire format)
>   smbus_read_word_swapped() - byte-swapped result for big-endian devices
>=20
> maxsize is 256, covering the SMBus command byte range 0x00-0xFF. This
> is the command byte space, not the 7-bit device address which is handled
> by the I2C core at adapter level.
>=20
> Link: https://lore.kernel.org/rust-for-linux/20260131-i2c-adapter-v1-4-5a=
436e34cd1a@gmail.com/
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git/commit/?h=3Ddriver-core-testing&id=3D121d87b28e1d9061d3aaa156c43a6=
27d3cb5e620
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>

Just to repeat myself (and I appreciate the challenges that exist for
rust support in general and that it may be easier to look at the
i2c layer) I think that if it we are looking at bindings that are
register like then regmap is the way to go.  The space of what you can
build that is register based and uses these i2c_smbus commands is a lot
richer than you might think.  Either you end up reinventing all the
infrastructure regmap has to handle these, or you just use regmap.

There are mixed devices where register stuff is used alongside other access=
es,
however for those I'm not sure it is worth doing anything other than
wrapping the raw bus access functions.

A few more references to the real variations we have to cope with inline.

Thanks

Jonathan

p.s. One day the rust driver in IIO won't be the bottom of my 'to review'
list :(

> ---
>  rust/kernel/bits.rs |  29 +++++
>  rust/kernel/i2c.rs  | 302 ++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/io.rs   |  66 +++++++---
>  3 files changed, 377 insertions(+), 20 deletions(-)
>=20
> diff --git a/rust/kernel/bits.rs b/rust/kernel/bits.rs
> index 2daead125626..a6537a668dd6 100644
> --- a/rust/kernel/bits.rs
> +++ b/rust/kernel/bits.rs
> @@ -41,6 +41,7 @@ pub const fn [<bit_ $ty>](n: u32) -> $ty {
>  impl_bit_fn!(u32);
>  impl_bit_fn!(u16);
>  impl_bit_fn!(u8);
> +impl_bit_fn!(usize);
> =20
>  macro_rules! impl_genmask_fn {
>      (
> @@ -203,3 +204,31 @@ pub const fn [<genmask_ $ty>](range: RangeInclusive<=
u32>) -> $ty {
>      /// assert_eq!(genmask_u8(0..=3D7), u8::MAX);
>      /// ```
>  );
> +
> +impl_genmask_fn!(
> +    usize,
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # #![expect(clippy::reversed_empty_ranges)]
> +    /// # use kernel::bits::genmask_checked_usize;
> +    /// assert_eq!(genmask_checked_usize(0..=3D0), Some(0b1));
> +    /// assert_eq!(genmask_checked_usize(0..=3D3), Some(0b1111));
> +    /// assert_eq!(genmask_checked_usize(1..=3D3), Some(0b1110));
> +    ///
> +    /// // `200` is out of the supported bit range on all platforms.
> +    /// assert_eq!(genmask_checked_usize(0..=3D200), None);
> +    ///
> +    /// // Invalid range where the start is bigger than the end.
> +    /// assert_eq!(genmask_checked_usize(5..=3D2), None);
> +    /// ```
> +    ,
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::bits::genmask_usize;
> +    /// assert_eq!(genmask_usize(0..=3D0), 0b1);
> +    /// assert_eq!(genmask_usize(0..=3D3), 0b1111);
> +    /// assert_eq!(genmask_usize(1..=3D3), 0b1110);
> +    /// ```
> +);
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 624b971ca8b0..f939907573a6 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -14,8 +14,15 @@
>      devres::Devres,
>      driver,
>      error::*,
> +    io::{
> +        FallibleIoCapable,
> +        IoBackend,
> +        IoBase,
> +        Region, //
> +    },
>      of,
>      prelude::*,
> +    ptr::KnownSize,
>      sync::aref::{
>          ARef,
>          AlwaysRefCounted, //
> @@ -601,3 +608,298 @@ unsafe impl Send for Registration {}
>  // SAFETY: `Registration` offers no interior mutability (no mutation thr=
ough &self
>  // and no mutable access is exposed)
>  unsafe impl Sync for Registration {}
> +
> +// SAFETY: `I2cClient<Bound>` wraps a kernel `struct i2c_client`. The I2=
C core
> +// and bus locking mechanisms ensure that the underlying client structur=
e can
> +// be safely transferred between threads.
> +unsafe impl Send for I2cClient<device::Bound> {}
> +
> +// SAFETY: `I2cClient<Bound>` wraps a kernel `struct i2c_client`. All me=
thods
> +// that access the client go through kernel I2C core functions that prov=
ide
> +// their own synchronization. No &self method exposes interior mutabilit=
y.
> +unsafe impl Sync for I2cClient<device::Bound> {}
> +
> +// SAFETY: `I2cClient<Bound>` is always reference-counted via the embedd=
ed
> +// `struct device`. `get_device`/`put_device` increment and decrement the
> +// device refcount atomically. A separate impl is needed for `I2cClient<=
Bound>`
> +// because `AlwaysRefCounted` is not implemented generically over all
> +// `DeviceContext`s =E2=80=94 only the specific contexts that are safe t=
o refcount
> +// from arbitrary threads.
> +unsafe impl AlwaysRefCounted for I2cClient<device::Bound> {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> +        unsafe { bindings::get_device(self.as_ref().as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::put_device(&raw mut (*obj.as_ref().as_raw()).=
dev) }
> +    }
> +}
> +
> +/// I/O backend for SMBus register access via I2C.
> +///
> +/// This backend implements only [`FallibleIoCapable`] and not [`IoCapab=
le`],
> +/// because I2C/SMBus bus transactions are inherently fallible =E2=80=94=
 NACK,
> +/// arbitration loss, and timeout can occur regardless of address validi=
ty.
> +/// The infallible [`Io::read`], [`Io::write`], and [`Io::update`] metho=
ds
> +/// are therefore compile-time unavailable for this backend.
> +pub struct I2cBackend;
> +
> +/// View type for [`I2cBackend`], carrying a reference to an I2C client =
and
> +/// a fake pointer that encodes the register offset and address-space si=
ze
> +/// as fat-pointer metadata.
> +///
> +/// The pointer field is never dereferenced. After [`IoBackend::project_=
view`]
> +/// projects an offset into the pointer, `addr()` yields that offset as =
the
> +/// SMBus command byte. [`KnownSize::size()`] reads the fat-pointer meta=
data
> +/// length (256 for the SMBus command space).
> +///
> +/// # Invariants
> +///
> +/// `ptr` is a non-dereferenceable fat pointer. Its address component en=
codes
> +/// the SMBus register offset (0..=3D255) after [`IoBackend::project_vie=
w`]
> +/// projection; its length metadata is 256 (the SMBus command byte addre=
ss
> +/// space). `client` points to a valid `I2cClient<Bound>` that remains l=
ive
> +/// for `'a`.
> +pub struct I2cView<'a, T: ?Sized> {
> +    client: &'a I2cClient<device::Bound>,
> +    ptr: *mut T,
> +}
> +
> +impl<T: ?Sized> Copy for I2cView<'_, T> {}
> +
> +impl<T: ?Sized> Clone for I2cView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl IoBackend for I2cBackend {
> +    type View<'a, T: ?Sized + KnownSize> =3D I2cView<'a, T>;
> +
> +    #[inline]
> +    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mu=
t T {
> +        view.ptr
> +    }
> +
> +    #[inline]
> +    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownS=
ize>(
> +        view: Self::View<'a, T>,
> +        ptr: *mut U,
> +    ) -> Self::View<'a, U> {
> +        // INVARIANT: Per safety requirement.
> +        I2cView {
> +            client: view.client,
> +            ptr,
> +        }
> +    }
> +}
> +
> +impl FallibleIoCapable<u8> for I2cBackend {
> +    #[inline]
> +    fn io_try_read<'a>(view: I2cView<'a, u8>) -> Result<u8> {
> +        // `io_view()` ensures `offset + 1 <=3D 256`, so `addr()` is at =
most 255;
> +        // the `as u8` cast below is therefore lossless.
> +        let reg =3D Self::as_ptr(view).addr() as u8;
> +        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i=
2c_client`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        // `i2c_smbus_read_byte_data` is safe to call with any valid cli=
ent pointer
> +        // and any u8 command byte.
> +        let ret =3D unsafe { bindings::i2c_smbus_read_byte_data(view.cli=
ent.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u8)
> +        }
> +    }
> +
> +    #[inline]
> +    fn io_try_write<'a>(view: I2cView<'a, u8>, value: u8) -> Result {
> +        // `io_view()` ensures `offset + 1 <=3D 256`, so `addr()` is at =
most 255;
> +        // the `as u8` cast below is therefore lossless.
> +        let reg =3D Self::as_ptr(view).addr() as u8;
> +        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i=
2c_client`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        // `i2c_smbus_write_byte_data` is safe to call with any valid cl=
ient pointer
> +        // and any u8 command byte and value.
> +        let ret =3D unsafe { bindings::i2c_smbus_write_byte_data(view.cl=
ient.as_raw(), reg, value) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +}
> +
> +impl FallibleIoCapable<u16> for I2cBackend {
> +    #[inline]
> +    fn io_try_read<'a>(view: I2cView<'a, u16>) -> Result<u16> {
> +        // `io_view()` ensures `offset + 2 <=3D 256`, so `addr()` is at =
most 254;
> +        // the `as u8` cast below is therefore lossless.
> +        let reg =3D Self::as_ptr(view).addr() as u8;
> +        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i=
2c_client`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        // `i2c_smbus_read_word_data` is safe to call with any valid cli=
ent pointer
> +        // and any u8 command byte.
> +        let ret =3D unsafe { bindings::i2c_smbus_read_word_data(view.cli=
ent.as_raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    #[inline]
> +    fn io_try_write<'a>(view: I2cView<'a, u16>, value: u16) -> Result {
> +        // `io_view()` ensures `offset + 2 <=3D 256`, so `addr()` is at =
most 254;

There are smbus devices that have fully 2 byte registers.  For those you'd
need to divide this by 2 and the range would go up to 510
E.g. drivers/light/cm32181.c (though that doesn't have that many registers).

> +        // the `as u8` cast below is therefore lossless.
> +        let reg =3D Self::as_ptr(view).addr() as u8;
> +        // SAFETY: `view.client.as_raw()` returns a valid `*mut struct i=
2c_client`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        // `i2c_smbus_write_word_data` is safe to call with any valid cl=
ient pointer
> +        // and any u8 command byte and u16 value.
> +        let ret =3D unsafe { bindings::i2c_smbus_write_word_data(view.cl=
ient.as_raw(), reg, value) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(())
> +        }
> +    }
> +}
...

> +impl I2cClient<device::Bound> {
> +    /// Returns an I/O handle for SMBus register access on this I2C clie=
nt.
> +    ///
> +    /// The returned handle provides fallible read/write methods for the
> +    /// 256-byte SMBus command address space (0x00=E2=80=930xFF). This i=
s the SMBus
> +    /// command byte range, NOT the 7-bit device address, which is handl=
ed
> +    /// by the I2C core at the adapter level.

That rather feels like you are correcting my confusion in the earlier versi=
on!=20
I'd assume people are more awake than me and skip the NOT part ;)

> +    ///
> +    /// Note: [`Io::try_read16`] and [`Io::try_write16`] on the returned=
 handle
> +    /// reject odd offsets. The underlying [`Region`] base address is 0,=
 so
> +    /// [`offset_valid`] checks `(0 + offset) % 2 =3D=3D 0` =E2=80=94 on=
ly even offsets
> +    /// pass. For word-sized access to odd-offset registers use
> +    /// [`smbus_read_word`] or [`smbus_read_word_swapped`] instead.
> +    ///
> +    /// The underlying pointer in the returned [`I2cView`] is never
> +    /// dereferenced; it encodes the register address space size as
> +    /// fat-pointer metadata and the register offset as the pointer addr=
ess.
> +    ///
> +    /// [`smbus_read_word`]: Self::smbus_read_word
> +    /// [`smbus_read_word_swapped`]: Self::smbus_read_word_swapped
> +    #[inline]
> +    pub fn smbus_io(&self) -> I2cView<'_, Region<256>> {
> +        // INVARIANT: `client` is `self`, a valid `I2cClient<Bound>`.
> +        //
> +        // `ptr` is a "fake pointer" =E2=80=94 it is constructed solely =
to carry two
> +        // pieces of metadata through the `IoBase` machinery:
> +        //   - address component: 0 initially; after each `project_view`=
 call,
> +        //     this becomes the register offset (the SMBus command byte).
> +        //   - length metadata: 256, encoding the SMBus command address =
space
> +        //     size so `io_view()` can bounds-check offsets.
> +        //
> +        // `without_provenance_mut(0)` produces a pointer with no memory
> +        // provenance =E2=80=94 it cannot be used to read or write memor=
y. This is safe
> +        // because `I2cBackend::as_ptr()` extracts the address as a `usi=
ze`
> +        // offset and passes it to `i2c_smbus_*` functions, never derefe=
rencing
> +        // the pointer itself. Using a provenance-free base avoids accid=
entally
> +        // creating a pointer that appears to alias real memory.
> +        I2cView {
> +            client: self,
> +            ptr: Region::<256>::ptr_from_raw_parts_mut(core::ptr::withou=
t_provenance_mut(0), 256),
> +        }
> +    }
> +
> +    /// Reads a 16-bit word from an SMBus register in CPU-native byte or=
der.
> +    ///
> +    /// Wraps `i2c_smbus_read_word_data`. The `reg` parameter is the SMB=
us
> +    /// command byte (0x00=E2=80=930xFF) =E2=80=94 an instruction sent t=
o the device over the
> +    /// serial bus, not a memory address. There is no alignment requirem=
ent:
> +    /// any command byte value is valid regardless of whether it is odd =
or even.

It might be a memory address, could be almost anything.  Maybe 'not necessa=
rily'
a memory address.
The kernel docs have it as:
"Command byte, a data byte which often selects a register on the device"

> +    ///
> +    /// SMBus transmits the low byte first (little-endian on the wire), =
and this
> +    /// method returns the value in CPU-native byte order without further
> +    /// conversion. Use [`Self::smbus_read_word_swapped`] for devices th=
at store
> +    /// multi-byte registers in big-endian (MSB-first) format.
> +    ///
> +    /// Returns `Err` if the bus transaction fails (e.g. NACK, arbitrati=
on loss,
> +    /// or timeout).
> +    #[inline]
> +    pub fn smbus_read_word(&self, reg: u8) -> Result<u16> {
> +        // SAFETY: `self.as_raw()` returns a valid `*mut struct i2c_clie=
nt`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        // `i2c_smbus_read_word_data` is safe to call with any valid cli=
ent
> +        // pointer and any u8 command byte.
> +        let ret =3D unsafe { bindings::i2c_smbus_read_word_data(self.as_=
raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Reads a 16-bit word from an SMBus register with bytes unconditio=
nally
> +    /// swapped.
> +    ///
> +    /// Wraps `i2c_smbus_read_word_data` and applies [`u16::swap_bytes`]=
 to the
> +    /// result. Use this for devices that store multi-byte registers in
> +    /// big-endian (MSB-first) format, which is common among I2C sensors=
 whose
> +    /// datasheets do not reference the SMBus specification.

This last bit feels like cover letter, patch description material.
I wouldn't normally expect function documentation to justify how useful
a function is!

> +    ///
> +    /// The swap is **unconditional** =E2=80=94 it is not equivalent to =
`be16_to_cpu`.
> +    /// On a big-endian CPU, `be16_to_cpu` would be a no-op, but this me=
thod
> +    /// still swaps. The reason: SMBus always transmits the low byte fir=
st, so
> +    /// the driver always receives data in little-endian wire order rega=
rdless
> +    /// of CPU endianness. The swap corrects for the device's wire-level=
 byte
> +    /// order, not the CPU's native order.

This feels like we are justifying why it isn't a different implementation.
Can we rewrite to not need that reference to what else it isn't.
=20
> +    ///
> +    /// The `reg` parameter is the SMBus command byte (0x00=E2=80=930xFF=
). There is no
> +    /// alignment requirement; any command byte value is valid.

What would an alignment requirement mean here?

> +    ///
> +    /// Returns `Err` if the bus transaction fails (e.g. NACK, arbitrati=
on loss,
> +    /// or timeout).
> +    ///
> +    /// # Example
> +    ///
> +    /// ```ignore
> +    /// // AS5600 stores the 12-bit raw angle big-endian at register 0x0=
C.
> +    /// let raw =3D client.smbus_read_word_swapped(0x0C)?;
> +    /// let angle =3D raw & 0x0FFF;
> +    /// ```
> +    #[inline]
> +    pub fn smbus_read_word_swapped(&self, reg: u8) -> Result<u16> {
> +        // SAFETY: `self.as_raw()` returns a valid `*mut struct i2c_clie=
nt`
> +        // pointer as guaranteed by the type invariant of `I2cClient`.
> +        let ret =3D unsafe { bindings::i2c_smbus_read_word_data(self.as_=
raw(), reg) };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok((ret as u16).swap_bytes())
> +        }
> +    }
> +}
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 95f46bb75f9e..516895ca2082 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -276,6 +276,36 @@ pub trait IoCapable<T>: IoBackend {
>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>  }
> =20
> +/// Fallible counterpart of [`IoCapable`] for I/O backends where operati=
ons can fail at the
> +/// transport level (e.g. I2C, SPI).
> +///

Why is this part in the patch adding the i2c specific use case?
I'd expect it to be a precursor patch.

> +/// Infallible backends ([`IoCapable`] implementors) get this for free v=
ia blanket implementation.
> +/// Fallible-only backends implement this trait directly without impleme=
nting [`IoCapable`]; the
> +/// infallible [`Io::read`], [`Io::write`], and [`Io::update`] methods w=
ill then be unavailable,
> +/// enforcing that callers use the `try_*` variants instead.
> +pub trait FallibleIoCapable<T>: IoBackend {
> +    /// Performs an I/O read of type `T` at `view` and returns the resul=
t, or an error if the
> +    /// transport-level operation fails.
> +    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T>;
> +
> +    /// Performs an I/O write of `value` at `view`, or returns an error =
if the transport-level
> +    /// operation fails.
> +    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result;
> +}
> +
> +impl<B: IoCapable<T>, T> FallibleIoCapable<T> for B {
> +    #[inline(always)]
> +    fn io_try_read<'a>(view: Self::View<'a, T>) -> Result<T> {
> +        Ok(Self::io_read(view))
> +    }
> +
> +    #[inline(always)]
> +    fn io_try_write<'a>(view: Self::View<'a, T>, value: T) -> Result {
> +        Self::io_write(view, value);
> +        Ok(())
> +    }
> +}
> +
>  /// Trait indicating that an I/O backend supports memory copy operations.
>  pub trait IoCopyable: IoBackend {
>      /// Copy contents of `view` to `buffer`.
> @@ -645,7 +675,7 @@ fn copy_to_slice(self, data: &mut [u8])
>      fn try_read8(self, offset: usize) -> Result<u8>
>      where
>          usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self::Backend: IoCapable<u8>,
> +        Self::Backend: FallibleIoCapable<u8>,
>      {
>          self.try_read(offset)
>      }
> @@ -655,7 +685,7 @@ fn try_read8(self, offset: usize) -> Result<u8>
>      fn try_read16(self, offset: usize) -> Result<u16>
>      where
>          usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self::Backend: IoCapable<u16>,
> +        Self::Backend: FallibleIoCapable<u16>,
>      {
>          self.try_read(offset)
>      }
> @@ -665,7 +695,7 @@ fn try_read16(self, offset: usize) -> Result<u16>
>      fn try_read32(self, offset: usize) -> Result<u32>
>      where
>          usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self::Backend: IoCapable<u32>,
> +        Self::Backend: FallibleIoCapable<u32>,
>      {
>          self.try_read(offset)
>      }
> @@ -675,7 +705,7 @@ fn try_read32(self, offset: usize) -> Result<u32>
>      fn try_read64(self, offset: usize) -> Result<u64>
>      where
>          usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self::Backend: IoCapable<u64>,
> +        Self::Backend: FallibleIoCapable<u64>,
>      {
>          self.try_read(offset)
>      }
> @@ -685,7 +715,7 @@ fn try_read64(self, offset: usize) -> Result<u64>
>      fn try_write8(self, value: u8, offset: usize) -> Result
>      where
>          usize: IoLoc<Self::Target, u8, IoType =3D u8>,
> -        Self::Backend: IoCapable<u8>,
> +        Self::Backend: FallibleIoCapable<u8>,
>      {
>          self.try_write(offset, value)
>      }
> @@ -695,7 +725,7 @@ fn try_write8(self, value: u8, offset: usize) -> Resu=
lt
>      fn try_write16(self, value: u16, offset: usize) -> Result
>      where
>          usize: IoLoc<Self::Target, u16, IoType =3D u16>,
> -        Self::Backend: IoCapable<u16>,
> +        Self::Backend: FallibleIoCapable<u16>,
>      {
>          self.try_write(offset, value)
>      }
> @@ -705,7 +735,7 @@ fn try_write16(self, value: u16, offset: usize) -> Re=
sult
>      fn try_write32(self, value: u32, offset: usize) -> Result
>      where
>          usize: IoLoc<Self::Target, u32, IoType =3D u32>,
> -        Self::Backend: IoCapable<u32>,
> +        Self::Backend: FallibleIoCapable<u32>,
>      {
>          self.try_write(offset, value)
>      }
> @@ -715,7 +745,7 @@ fn try_write32(self, value: u32, offset: usize) -> Re=
sult
>      fn try_write64(self, value: u64, offset: usize) -> Result
>      where
>          usize: IoLoc<Self::Target, u64, IoType =3D u64>,
> -        Self::Backend: IoCapable<u64>,
> +        Self::Backend: FallibleIoCapable<u64>,
>      {
>          self.try_write(offset, value)
>      }
> @@ -827,10 +857,10 @@ fn write64(self, value: u64, offset: usize)
>      fn try_read<T, L>(self, location: L) -> Result<T>
>      where
>          L: IoLoc<Self::Target, T>,
> -        Self::Backend: IoCapable<L::IoType>,
> +        Self::Backend: FallibleIoCapable<L::IoType>,
>      {
>          let view =3D io_view::<Self, L::IoType>(self, location.offset())=
?;
> -        Ok(Self::Backend::io_read(view).into())
> +        Ok(Self::Backend::io_try_read(view)?.into())
>      }
> =20
>      /// Generic fallible write with runtime bounds check.
> @@ -860,12 +890,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
>      fn try_write<T, L>(self, location: L, value: T) -> Result
>      where
>          L: IoLoc<Self::Target, T>,
> -        Self::Backend: IoCapable<L::IoType>,
> +        Self::Backend: FallibleIoCapable<L::IoType>,
>      {
>          let view =3D io_view::<Self, L::IoType>(self, location.offset())=
?;
>          let io_value =3D value.into();
> -        Self::Backend::io_write(view, io_value);
> -        Ok(())
> +        Self::Backend::io_try_write(view, io_value)
>      }
> =20
>      /// Generic fallible write of a fully-located register value.
> @@ -905,7 +934,7 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
>      where
>          L: IoLoc<Self::Target, T>,
>          V: LocatedRegister<Self::Target, Location =3D L, Value =3D T>,
> -        Self::Backend: IoCapable<L::IoType>,
> +        Self::Backend: FallibleIoCapable<L::IoType>,
>      {
>          let (location, value) =3D value.into_io_op();
> =20
> @@ -938,16 +967,13 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
>      fn try_update<T, L, F>(self, location: L, f: F) -> Result
>      where
>          L: IoLoc<Self::Target, T>,
> -        Self::Backend: IoCapable<L::IoType>,
> +        Self::Backend: FallibleIoCapable<L::IoType>,
>          F: FnOnce(T) -> T,
>      {
>          let view =3D io_view::<Self, L::IoType>(self, location.offset())=
?;
> -
> -        let value: T =3D Self::Backend::io_read(view).into();
> +        let value: T =3D Self::Backend::io_try_read(view)?.into();
>          let io_value =3D f(value).into();
> -        Self::Backend::io_write(view, io_value);
> -
> -        Ok(())
> +        Self::Backend::io_try_write(view, io_value)
>      }
> =20
>      /// Generic infallible read with compile-time bounds check.

