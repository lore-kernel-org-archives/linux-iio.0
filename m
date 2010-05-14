Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 14 May 2010 12:18:03 +0100
Subject: max1363 driver comments 
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568FC025@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,


/* Todo: test this */
int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
{
        unsigned long numvals;
        int count =3D 0, ret;
        u8 *ring_data;
        if (!(st->current_mode->modemask & mask)) {
                ret =3D -EBUSY;
                goto error_ret;
        }
        numvals =3D hweight_long(st->current_mode->modemask);

        ring_data =3D kmalloc(numvals*2, GFP_KERNEL);
        if (ring_data =3D=3D NULL) {
                ret =3D -ENOMEM;
                goto error_ret;
        }
        ret =3D st->indio_dev->ring->access.read_last(st->indio_dev->ring,
                                                ring_data);
        if (ret)
                goto error_free_ring_data;
        /* Need a count of channels prior to this one */
        mask >>=3D 1;
        while (mask) {
                if (mask && st->current_mode->modemask)
                        count++;
                mask >>=3D 1;
        }
        if (st->chip_info->bits !=3D 8)
                return ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
                        + (int)(ring_data[count*2 + 1]);
        else
                return ring_data[count];

error_free_ring_data:
        kfree(ring_data);
error_ret:
        return ret;
}

1) Where does ring_data get freed?
2) if (mask && st->current_mode->modemask)? Shouldn't this be a Bitwise AND=
 & ?


static int __devinit max1363_probe(struct i2c_client *client,
                                   const struct i2c_device_id *id)
{

[--snip--]

        /* Find the chip model specific data */
        for (i =3D 0; i < ARRAY_SIZE(max1363_chip_info_tbl); i++)
                if (!strcmp(max1363_chip_info_tbl[i].name, id->name)) {
                        st->chip_info =3D &max1363_chip_info_tbl[i];
                        break;
                };

Isn't this what id->driver_data is for?

st->chip_info =3D &max1363_chip_info_tbl[id->driver_data];

In case you want to make this bullet prove - use distinct offsets.
See example below.

/* max1363 and max1368 tested - rest from data sheet */
static const struct max1363_chip_info max1363_chip_info_tbl[] =3D {
-       {
+       [max1361] =3D {
                .name =3D "max1361",
                .num_inputs =3D 4,
                .bits =3D 10,
                .int_vref_mv =3D 2048,
                .monitor_mode =3D 1,
                .mode_list =3D max1363_mode_list,
                .num_modes =3D ARRAY_SIZE(max1363_mode_list),
                .default_mode =3D s0to3,
                .dev_attrs =3D &max1363_dev_attr_group,
                .scan_attrs =3D &max1363_scan_el_group,
        }, {

-Michael


------------------------------------------------------------------
********* Analog Devices GmbH              Open Platform Solutions
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel, W=
illiam A. Martin, Margaret K. Seif
